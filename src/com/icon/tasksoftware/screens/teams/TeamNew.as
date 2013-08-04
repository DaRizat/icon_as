package com.icon.tasksoftware.screens.teams
{
	import com.icon.tasksoftware.Faker.Faker;
	import com.icon.tasksoftware.controls.ApplicationScreen;
	import com.icon.tasksoftware.controls.DropDownHeader;
	import com.icon.tasksoftware.data.WebServiceEndpoints;
	import com.icon.tasksoftware.data.WebServiceRequest;
	import com.icon.tasksoftware.data.WebServiceResponse;
	import com.icon.tasksoftware.data.models.Team;
	import com.icon.tasksoftware.events.EventHub;
	import com.icon.tasksoftware.events.WebServiceRequestEvent;
	import com.icon.tasksoftware.events.WebServiceResponseEvent;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.TextInput;
	import feathers.themes.IconMobileTheme;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class TeamNew extends ApplicationScreen
	{
		private var header:DropDownHeader;
		private var backButton:Button;
		
		private var nameLabel:Label;
		private var nameInput:TextInput;
		private var iconLabel:Label;
		private var iconInput:TextInput;
		
		private var cancelButton:Button;
		private var submitButton:Button;
		
		private var _team:Team;
		
		public function TeamNew()
		{
			super();
			screen_name = Main.TEAM_NEW;
			
			addEventListener(Event.ADDED_TO_STAGE, reset);
		}
		
		private function reset(e:Event):void
		{
			team = null;
			
			nameInput.text = "";
			nameInput.isEnabled = true;
			iconInput.text = "";
			iconInput.isEnabled = true;
			
			cancelButton.isEnabled = true;
			submitButton.isEnabled = true;
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
			
			iconLabel.x = 18;
			iconLabel.y = nameInput.y + 64;
			iconLabel.width = actualWidth - 36;
			
			iconInput.x = 18;
			iconInput.y = iconLabel.y + 36;
			iconInput.width = actualWidth - 36;
			
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
					case WebServiceEndpoints.TEAM_CREATE:
						dispatchEventWith("back", false, team);
						break;
				}
			}
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			header = new DropDownHeader(DropDownHeader.TEAMS);
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
			
			iconLabel = new Label();
			iconLabel.text = "Icon:";
			addChild(iconLabel);
			
			iconInput = new TextInput();
			addChild(iconInput);
			
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
			dispatchEventWith("back");
		}
		
		private function onCancel(e:Event):void
		{
			dispatchEventWith("back", false, team);
		}
		
		private function onSubmit(e:Event):void
		{
			nameInput.isEnabled = false;
			iconInput.isEnabled = false;
			cancelButton.isEnabled = false;
			submitButton.isEnabled = false;
			
			// TODO: validate input
			
			team = new Team();
			team.id = Faker.instance.GenerateID();
			team.name = nameInput.text;
			team.icon = iconInput.text;
			var request:WebServiceRequest = new WebServiceRequest(WebServiceEndpoints.TEAM_CREATE, screen_name, team);
			EventHub.instance.relay(new WebServiceRequestEvent(request));
		}
		
		public function get team():Team { return _team; }
		public function set team(value:Team):void
		{
			_team = value;
			invalidate( INVALIDATION_FLAG_DATA );
		}
	}
}