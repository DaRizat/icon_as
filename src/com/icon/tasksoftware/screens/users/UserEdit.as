package com.icon.tasksoftware.screens.users
{
	import com.icon.tasksoftware.controls.ApplicationScreen;
	import com.icon.tasksoftware.controls.DropDownHeader;
	import com.icon.tasksoftware.data.WebServiceEndpoints;
	import com.icon.tasksoftware.data.WebServiceRequest;
	import com.icon.tasksoftware.data.WebServiceResponse;
	import com.icon.tasksoftware.data.models.User;
	import com.icon.tasksoftware.events.EventHub;
	import com.icon.tasksoftware.events.WebServiceRequestEvent;
	import com.icon.tasksoftware.events.WebServiceResponseEvent;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.TextInput;
	import feathers.themes.IconMobileTheme;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class UserEdit extends ApplicationScreen
	{
		private var header:DropDownHeader;
		private var backButton:Button;
		
		private var nameLabel:Label;
		private var nameInput:TextInput;
		private var emailLabel:Label;
		private var emailInput:TextInput;
		
		private var cancelButton:Button;
		private var submitButton:Button;
		
		private var _user:User;
		private var _user_id:String;
		
		public function UserEdit()
		{
			super();
			screen_name = Main.USER_EDIT;
			
			addEventListener(Event.ADDED_TO_STAGE, reset);
		}
		
		private function reset(e:Event):void
		{
			user = null;
			
			nameInput.text = "";
			nameInput.isEnabled = false;
			emailInput.text = "";
			emailInput.isEnabled = false;
			
			cancelButton.isEnabled = false;
			submitButton.isEnabled = false;
			
			var request:WebServiceRequest = new WebServiceRequest(WebServiceEndpoints.construct(WebServiceEndpoints.USER_READ, {user:user_id}), screen_name);
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
			
			emailLabel.x = 18;
			emailLabel.y = nameInput.y + 64;
			emailLabel.width = actualWidth - 36;
			
			emailInput.x = 18;
			emailInput.y = emailLabel.y + 36;
			emailInput.width = actualWidth - 36;
			
			if(user)
			{
				nameInput.text = user.name;
				emailInput.text = user.email;
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
					case WebServiceEndpoints.USER_UPDATE:
						dispatchEventWith("back", false, user);
						break;
					case WebServiceEndpoints.USER_READ:
						user = User(response.data);
						nameInput.text = user.name;
						emailInput.text = user.email;
						
						nameInput.isEnabled = true;
						emailInput.isEnabled = true;
						cancelButton.isEnabled = true;
						submitButton.isEnabled = true;
						
						break;
				}
			}
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			header = new DropDownHeader(DropDownHeader.USERS);
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
			
			emailLabel = new Label();
			emailLabel.text = "Email:";
			addChild(emailLabel);
			
			emailInput = new TextInput();
			addChild(emailInput);
			
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
			dispatchEventWith("back", false, user);
		}
		
		private function onCancel(e:Event):void
		{
			dispatchEventWith("back", false, user);
		}
		
		private function onSubmit(e:Event):void
		{
			nameInput.isEnabled = false;
			emailInput.isEnabled = false;
			cancelButton.isEnabled = false;
			submitButton.isEnabled = false;
			
			// TODO: validate input
			
			user.name = nameInput.text;
			user.email = emailInput.text;
			var request:WebServiceRequest = new WebServiceRequest(WebServiceEndpoints.USER_UPDATE, screen_name, user);
			EventHub.instance.relay(new WebServiceRequestEvent(request));
		}
		
		public function get user():User { return _user; }
		public function set user(value:User):void
		{
			_user = value;
			invalidate( INVALIDATION_FLAG_DATA );
		}
		
		public function get user_id():String { return _user_id; }
		public function set user_id(value:String):void
		{
			_user_id = value;
			invalidate( INVALIDATION_FLAG_DATA );
		}
	}
}