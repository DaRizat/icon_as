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
	import feathers.controls.TextInput;
	import feathers.themes.IconMobileTheme;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class OrganizationEdit extends ApplicationScreen
	{
		
		private var header:DropDownHeader;
		private var backButton:Button;
		
		private var nameLabel:Label;
		private var nameInput:TextInput;
		private var cancelButton:Button;
		private var submitButton:Button;
		
		private var _organization:Organization;
		private var _organization_id:String;
		
		public function OrganizationEdit()
		{
			super();
			screen_name = Main.ORGANIZATION_EDIT;
			
			addEventListener(Event.ADDED_TO_STAGE, reset);
		}
		
		private function reset(e:Event):void
		{
			organization = null;
			
			nameInput.isEnabled = false;
			cancelButton.isEnabled = false;
			submitButton.isEnabled = false;
			
			nameInput.text = "";
			
			var request:WebServiceRequest = new WebServiceRequest(WebServiceEndpoints.construct(WebServiceEndpoints.ORGANIZATION_READ, {organization:organization_id}), screen_name);
			EventHub.instance.relay(new WebServiceRequestEvent(request));
		}
		
		override protected function draw():void
		{
			header.width = actualWidth;
			
			nameLabel.x = 18;
			nameLabel.y = header.height + 18;
			nameLabel.width = actualWidth - 36;
			
			nameInput.x = 18;
			nameInput.y = nameLabel.y + 36;
			nameInput.width = actualWidth - 36;
			if(organization)
			{
				nameInput.text = organization.name;
			}
			
			cancelButton.width = (actualWidth - 54) / 2.0;
			cancelButton.height = 64;
			cancelButton.x = 18;
			cancelButton.y = actualHeight - cancelButton.height - 18;
			
			submitButton.width = (actualWidth - 54) / 2.0;
			submitButton.height = 64;
			submitButton.x = cancelButton.x + cancelButton.width + 18;
			submitButton.y = actualHeight - submitButton.height - 18;
		}
		
		override public function onWebServiceResponse(event:WebServiceResponseEvent):void
		{
			if(event.type == WebServiceResponseEvent.STATUS_SUCCESS)
			{
				var response:WebServiceResponse = event.data as WebServiceResponse;
				switch(response.endpoint)
				{
					case WebServiceEndpoints.ORGANIZATION_UPDATE:
						dispatchEventWith("back", false, organization);
						break;
					case WebServiceEndpoints.ORGANIZATION_READ:
						organization = Organization(response.data);
						nameInput.text = organization.name;
						
						nameInput.isEnabled = true;
						cancelButton.isEnabled = true;
						submitButton.isEnabled = true;
						
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
			
			nameLabel = new Label();
			nameLabel.text = "Name:";
			addChild(nameLabel);
			
			nameInput = new TextInput();
			addChild(nameInput);
			
			cancelButton = new Button();
			cancelButton.label = "Cancel";
			cancelButton.addEventListener(Event.TRIGGERED, onCancel);
			addChild(cancelButton);
			
			submitButton = new Button();
			submitButton.label = "OK";
			submitButton.addEventListener(Event.TRIGGERED, onSubmit);
			addChild(submitButton);
		}
		
		private function onBack(e:Event):void
		{
			dispatchEventWith("back", false, organization);
		}
		
		private function onCancel(e:Event):void
		{
			dispatchEventWith("back", false, organization);
		}
		
		private function onSubmit(e:Event):void
		{
			nameInput.isEnabled = false;
			cancelButton.isEnabled = false;
			submitButton.isEnabled = false;
			
			// TODO: validate input
			
			organization.name = nameInput.text;
			var request:WebServiceRequest = new WebServiceRequest(WebServiceEndpoints.ORGANIZATION_UPDATE, screen_name, organization);
			EventHub.instance.relay(new WebServiceRequestEvent(request));
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