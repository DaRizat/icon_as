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
	import feathers.controls.TextInput;
	import feathers.themes.IconMobileTheme;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class RoleEdit extends ApplicationScreen
	{
		
		private var header:DropDownHeader;
		private var backButton:Button;
		
		private var nameLabel:Label;
		private var nameInput:TextInput;
		private var cancelButton:Button;
		private var submitButton:Button;
		
		private var _role:Role;
		private var _role_id:String;
		
		public function RoleEdit()
		{
			super();
			screen_name = Main.ROLE_EDIT;
			
			addEventListener(Event.ADDED_TO_STAGE, reset);
		}
		
		private function reset(e:Event):void
		{
			role = null;
			
			nameInput.isEnabled = false;
			cancelButton.isEnabled = false;
			submitButton.isEnabled = false;
			
			nameInput.text = "";
			
			var request:WebServiceRequest = new WebServiceRequest(WebServiceEndpoints.construct(WebServiceEndpoints.ROLE_READ, {role:role_id}), screen_name);
			EventHub.instance.relay(new WebServiceRequestEvent(request));
		}
		
		override protected function draw():void
		{
			header.width = actualWidth;
			
			nameLabel.x = 18;
			nameLabel.y = header.height + 18;
			nameLabel.width = actualWidth - 36;
			
			nameInput.x = 18;
			nameInput.y = nameLabel.y + nameLabel.height + nameInput.paddingTop;
			nameInput.width = actualWidth - 36;
			if(role)
			{
				nameInput.text = role.name;
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
					case WebServiceEndpoints.ROLE_UPDATE:
						dispatchEventWith("back", false, role);
						break;
					case WebServiceEndpoints.ROLE_READ:
						role = Role(response.data);
						nameInput.text = role.name;
						
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
			
			header = new DropDownHeader(DropDownHeader.ROLES);
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
			dispatchEventWith("back", false, role);
		}
		
		private function onCancel(e:Event):void
		{
			dispatchEventWith("back", false, role);
		}
		
		private function onSubmit(e:Event):void
		{
			nameInput.isEnabled = false;
			cancelButton.isEnabled = false;
			submitButton.isEnabled = false;
			
			// TODO: validate input
			
			role.name = nameInput.text;
			var request:WebServiceRequest = new WebServiceRequest(WebServiceEndpoints.ROLE_UPDATE, screen_name, role);
			EventHub.instance.relay(new WebServiceRequestEvent(request));
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