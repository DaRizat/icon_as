package com.icon.tasksoftware.controls.data
{
	public class DialogButton
	{
		private var _label:String;
		private var _callback:Function;
		
		public function DialogButton(label:String, callback:Function)
		{
			_label = label;
			_callback = callback;
		}
		
		public function get label():String { return _label; }
		public function get callback():Function { return _callback; }
	}
}