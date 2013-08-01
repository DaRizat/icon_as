package com.icon.tasksoftware.screens.organizations
{
	import com.icon.tasksoftware.controls.ApplicationScreen;
	import com.icon.tasksoftware.controls.DropDownHeader;
	import com.icon.tasksoftware.events.WebServiceResponseEvent;
	
	import feathers.controls.Button;
	import feathers.themes.IconMobileTheme;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class OrganizationNew extends ApplicationScreen
	{
		private var header:DropDownHeader;
		private var backButton:Button;
		
		public function OrganizationNew()
		{
			super();
			screen_name = Main.ORGANIZATION_NEW;
		}
		
		override protected function draw():void
		{
			header.width = actualWidth;
		}
		
		override public function onWebServiceResponse(event:WebServiceResponseEvent):void
		{
			
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
		}
		
		private function onBack(e:Event):void
		{
			dispatchEventWith("back");
		}
	}
}