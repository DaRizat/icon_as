package com.icon.tasksoftware.screens.roles
{
	import com.icon.tasksoftware.controls.ApplicationScreen;
	import com.icon.tasksoftware.controls.DropDownHeader;
	import com.icon.tasksoftware.data.WebServiceEndpoints;
	import com.icon.tasksoftware.data.WebServiceRequest;
	import com.icon.tasksoftware.data.WebServiceResponse;
	import com.icon.tasksoftware.data.models.Role;
	import com.icon.tasksoftware.events.EventHub;
	import com.icon.tasksoftware.events.WebServiceRequestEvent;
	import com.icon.tasksoftware.events.WebServiceResponseEvent;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.themes.IconMobileTheme;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class RoleShow extends ApplicationScreen
	{
		private var header:DropDownHeader;
		private var backButton:Button;
		
		private var roleLabel:Label;
		private var editButton:Button;
		
		private var _role:Role;
		private var _role_id:String;
		
		public function RoleShow()
		{
			super();
			screen_name = Main.ROLE_SHOW;
			
			addEventListener(Event.ADDED_TO_STAGE, reset);
		}
		
		private function reset(e:Event):void
		{
			role = null;
			
			roleLabel.text = "";
			
			var request:WebServiceRequest = new WebServiceRequest(WebServiceEndpoints.construct(WebServiceEndpoints.ROLE_READ, {role:role_id}), screen_name);
			EventHub.instance.relay(new WebServiceRequestEvent(request));
		}
		
		override protected function draw():void
		{
			header.width = actualWidth;
			
			roleLabel.x = 18;
			roleLabel.y = header.height + 18;
			roleLabel.width = actualWidth - 36;
			
			if(role)
			{
				roleLabel.text = role.name;
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
					case WebServiceEndpoints.ROLE_READ:
						role = Role(response.data);
						roleLabel.text = role.name;
						break;
				}
			}
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			header = new DropDownHeader(DropDownHeader.ROLES);
			addChild(header);
			
			backButton = new Button();
			backButton.label = "Back";
			backButton.nameList.add(IconMobileTheme.BACK_BUTTON);
			backButton.addEventListener(Event.TRIGGERED, onBack);
			header.leftItems = new <DisplayObject>[backButton];
			
			roleLabel = new Label();
			roleLabel.nameList.add(IconMobileTheme.PAGE_HEADER);
			addChild(roleLabel);
			
			editButton = new Button();
			editButton.label = "Edit";
			editButton.addEventListener(Event.TRIGGERED, onEdit);
			addChild(editButton);
		}
		
		private function onBack(e:Event):void
		{
			dispatchEventWith("back", false, role);
		}
		
		private function onEdit(e:Event):void
		{
			dispatchEventWith("roleEdit", false, role);
		}
		
		public function get role():Role { return _role; }
		public function set role(value:Role):void
		{
			_role = value;
			invalidate( INVALIDATION_FLAG_DATA );
		}
		
		public function get role_id():String { return _role_id; }
		public function set role_id(value:String):void
		{
			_role_id = value;
			invalidate( INVALIDATION_FLAG_DATA );
		}
	}
}