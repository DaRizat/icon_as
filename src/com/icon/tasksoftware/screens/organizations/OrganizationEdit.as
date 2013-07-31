package com.icon.tasksoftware.screens.organizations
{
	import com.icon.tasksoftware.controls.ApplicationScreen;
	import com.icon.tasksoftware.controls.DropDownHeader;
	import com.icon.tasksoftware.data.models.Organization;
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
		
		public function OrganizationEdit()
		{
			super();
			screen_name = Main.ORGANIZATION_EDIT;
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
			
		}
		
		override protected function initialize():void
		{
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
			if(organization)
			{
				nameInput.text = organization.name;
			}
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
			// TODO: validate input
			organization.name = nameInput.text;
			// TODO: POST /organization/{organization.id}
			dispatchEventWith("back", false, organization);
		}
		
		public function get organization():Organization { return _organization; }
		public function set organization(value:Organization):void
		{
			_organization = value;
			invalidate( INVALIDATION_FLAG_DATA );
		}
	}
}