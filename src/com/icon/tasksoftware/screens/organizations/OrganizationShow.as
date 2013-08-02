package com.icon.tasksoftware.screens.organizations
{
	import com.icon.tasksoftware.controls.ApplicationScreen;
	import com.icon.tasksoftware.controls.DropDownHeader;
	import com.icon.tasksoftware.data.WebServiceEndpoints;
	import com.icon.tasksoftware.data.WebServiceRequest;
	import com.icon.tasksoftware.data.WebServiceResponse;
	import com.icon.tasksoftware.data.models.Organization;
	import com.icon.tasksoftware.events.EventHub;
	import com.icon.tasksoftware.events.WebServiceRequestEvent;
	import com.icon.tasksoftware.events.WebServiceResponseEvent;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.themes.IconMobileTheme;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class OrganizationShow extends ApplicationScreen
	{
		private var header:DropDownHeader;
		private var backButton:Button;
		
		private var organizationLabel:Label;
		private var editButton:Button;
		
		private var _organization:Organization;
		private var _organization_id:String;
		
		public function OrganizationShow()
		{
			super();
			screen_name = Main.ORGANIZATION_SHOW;
			
			addEventListener(Event.ADDED_TO_STAGE, reset);
		}
		
		private function reset(e:Event):void
		{
			organization = null;
			
			organizationLabel.text = "";
			
			var request:WebServiceRequest = new WebServiceRequest(WebServiceEndpoints.construct(WebServiceEndpoints.ORGANIZATION_READ, {organization:organization_id}), screen_name);
			EventHub.instance.relay(new WebServiceRequestEvent(request));
		}
		
		override protected function draw():void
		{
			header.width = actualWidth;
			
			organizationLabel.x = 18;
			organizationLabel.y = header.height + 18;
			organizationLabel.width = actualWidth - 36;
			
			if(organization)
			{
				organizationLabel.text = organization.name;
			}
			
			editButton.width = actualWidth - 36;
			editButton.height = 64;
			editButton.x = 18;
			editButton.y = actualHeight - editButton.height - 18;
		}
		
		override public function onWebServiceResponse(event:WebServiceResponseEvent):void
		{
			if(event.type == WebServiceResponseEvent.STATUS_SUCCESS)
			{
				var response:WebServiceResponse = event.data as WebServiceResponse;
				switch(response.endpoint)
				{
					case WebServiceEndpoints.ORGANIZATION_READ:
						organization = Organization(response.data);
						organizationLabel.text = organization.name;
						break;
				}
			}
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			header = new DropDownHeader(DropDownHeader.ORGANIZATIONS);
			addChild(header);
			
			backButton = new Button();
			backButton.label = "Back";
			backButton.nameList.add(IconMobileTheme.BACK_BUTTON);
			backButton.addEventListener(Event.TRIGGERED, onBack);
			header.leftItems = new <DisplayObject>[backButton];
			
			organizationLabel = new Label();
			organizationLabel.nameList.add(IconMobileTheme.PAGE_HEADER);
			addChild(organizationLabel);
			
			editButton = new Button();
			editButton.label = "Edit";
			editButton.addEventListener(Event.TRIGGERED, onEdit);
			addChild(editButton);
		}
		
		private function onBack(e:Event):void
		{
			dispatchEventWith("back", false, organization);
		}
		
		private function onEdit(e:Event):void
		{
			dispatchEventWith("organizationEdit", false, organization);
		}
		
		public function get organization():Organization { return _organization; }
		public function set organization(value:Organization):void
		{
			_organization = value;
			invalidate( INVALIDATION_FLAG_DATA );
		}
		
		public function get organization_id():String { return _organization_id; }
		public function set organization_id(value:String):void
		{
			_organization_id = value;
			invalidate( INVALIDATION_FLAG_DATA );
		}
	}
}