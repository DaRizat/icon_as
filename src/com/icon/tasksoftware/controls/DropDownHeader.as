package com.icon.tasksoftware.controls
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	
	import starling.events.Event;
	
	public class DropDownHeader extends Header
	{
		private static const MAX_DRAG_DIST:Number = 50;
		
		private var mIsDown:Boolean;
		
		private var _dropdownButton:Button;
		
		public function DropDownHeader()
		{
			super();
		}
		
		override protected function draw():void
		{
			super.draw();
			
			_dropdownButton.width = _titleRenderer.width + 64;
			_dropdownButton.height = this.height - 32;
			_dropdownButton.y = 16;
			_dropdownButton.x = _titleRenderer.x - 32;
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			_dropdownButton = new Button();
			_dropdownButton.alpha = 0;
			_dropdownButton.addEventListener(Event.TRIGGERED, onTriggered);
			addChild(_dropdownButton);
		}
		
		public function onTriggered(e:Event):void
		{
			trace("TRIGGERED");
		}
	}
}