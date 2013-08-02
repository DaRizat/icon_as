package com.icon.tasksoftware.controls.data
{
	public class DialogData
	{
		private var _title:String;
		private var _description:String;
		private var _buttons:Vector.<DialogButton>;
		
		public function DialogData(title:String, description:String, buttons:Vector.<DialogButton>)
		{
			this.title = title;
			this.description = description;
			this.buttons = buttons;
		}
		
		public function get title():String { return _title; }
		public function set title(value:String):void
		{
			_title = value;
		}
		
		public function get description():String { return _description; }
		public function set description(value:String):void
		{
			_description = value;
		}
		
		public function get buttons():Vector.<DialogButton> { return _buttons; }
		public function set buttons(value:Vector.<DialogButton>):void
		{
			_buttons = value;
		}
	}
}