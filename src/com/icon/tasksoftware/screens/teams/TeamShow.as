package com.icon.tasksoftware.screens.teams
{
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
	import feathers.themes.IconMobileTheme;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class TeamShow extends ApplicationScreen
	{
		private var header:DropDownHeader;
		private var backButton:Button;
		
		private var teamLabel:Label;
		private var teamIcon:Label;
		private var editButton:Button;
		
		private var _team:Team;
		private var _team_id:String;
		
		public function TeamShow()
		{
			super();
			screen_name = Main.TEAM_SHOW;
			
			addEventListener(Event.ADDED_TO_STAGE, reset);
		}
		
		private function reset(e:Event):void
		{
			team = null;
			
			teamLabel.text = "";
			
			var request:WebServiceRequest = new WebServiceRequest(WebServiceEndpoints.construct(WebServiceEndpoints.TEAM_READ, {team:team_id}), screen_name);
			EventHub.instance.relay(new WebServiceRequestEvent(request));
		}
		
		override protected function draw():void
		{
			header.width = actualWidth;
			
			teamLabel.x = 18;
			teamLabel.y = header.height + 18;
			teamLabel.width = actualWidth - 36;
			
			teamIcon.x = 18;
			teamIcon.y = teamLabel.y + 64;
			teamIcon.width = actualWidth - 36;
			
			if(team)
			{
				teamLabel.text = team.name;
				teamIcon.text = team.icon;
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
					case WebServiceEndpoints.TEAM_READ:
						team = Team(response.data);
						teamLabel.text = team.name;
						teamIcon.text = team.icon;
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
			
			teamLabel = new Label();
			teamLabel.nameList.add(IconMobileTheme.PAGE_HEADER);
			addChild(teamLabel);
			
			teamIcon = new Label();
			teamIcon.nameList.add(IconMobileTheme.PAGE_HEADER);
			addChild(teamIcon);
			
			editButton = new Button();
			editButton.label = "Edit";
			editButton.addEventListener(Event.TRIGGERED, onEdit);
			addChild(editButton);
		}
		
		private function onBack(e:Event):void
		{
			dispatchEventWith("back", false, team);
		}
		
		private function onEdit(e:Event):void
		{
			dispatchEventWith("teamEdit", false, team);
		}
		
		public function get team():Team { return _team; }
		public function set team(value:Team):void
		{
			_team = value;
			invalidate( INVALIDATION_FLAG_DATA );
		}
		
		public function get team_id():String { return _team_id; }
		public function set team_id(value:String):void
		{
			_team_id = value;
			invalidate( INVALIDATION_FLAG_DATA );
		}
	}
}