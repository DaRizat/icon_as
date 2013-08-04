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
	import feathers.themes.IconMobileTheme;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class UserShow extends ApplicationScreen
	{
		private var header:DropDownHeader;
		private var backButton:Button;
		
		private var userLabel:Label;
		private var userEmail:Label;
		private var editButton:Button;
		
		private var _user:User;
		private var _user_id:String;
		
		public function UserShow()
		{
			super();
			screen_name = Main.USER_SHOW;
			
			addEventListener(Event.ADDED_TO_STAGE, reset);
		}
		
		private function reset(e:Event):void
		{
			user = null;
			
			userLabel.text = "";
			userEmail.text = "";
			
			var request:WebServiceRequest = new WebServiceRequest(WebServiceEndpoints.construct(WebServiceEndpoints.USER_READ, {user:user_id}), screen_name);
			EventHub.instance.relay(new WebServiceRequestEvent(request));
		}
		
		override protected function draw():void
		{
			header.width = actualWidth;
			
			userLabel.x = 18;
			userLabel.y = header.height + 18;
			userLabel.width = actualWidth - 36;
			
			userEmail.x = 18;
			userEmail.y = userLabel.y + 64;
			userEmail.width = actualWidth - 36;
			
			if(user)
			{
				userLabel.text = user.name;
				userEmail.text = user.email;
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
					case WebServiceEndpoints.USER_READ:
						user = User(response.data);
						userLabel.text = user.name;
						userEmail.text = user.email;
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
			
			userLabel = new Label();
			userLabel.nameList.add(IconMobileTheme.PAGE_HEADER);
			addChild(userLabel);
			
			userEmail = new Label();
			userEmail.nameList.add(IconMobileTheme.PAGE_HEADER);
			addChild(userEmail);
			
			editButton = new Button();
			editButton.label = "Edit";
			editButton.addEventListener(Event.TRIGGERED, onEdit);
			addChild(editButton);
		}
		
		private function onBack(e:Event):void
		{
			dispatchEventWith("back", false, user);
		}
		
		private function onEdit(e:Event):void
		{
			dispatchEventWith("userEdit", false, user);
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