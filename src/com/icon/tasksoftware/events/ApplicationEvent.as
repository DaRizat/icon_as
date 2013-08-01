package com.icon.tasksoftware.events
{
	import starling.events.Event;
	
	public class ApplicationEvent extends Event
	{
		public static var CHANGE_MODEL:String = "CHANGE_MODEL";
		public static var DIALOG_OPEN:String = "DIALOG_OPEN";
		public static var DIALOG_CLOSE:String = "DIALOG_CLOSE";
		
		public function ApplicationEvent(type:String, bubbles:Boolean = false, data:Object = null)
		{
			super(type, false, data);
		}
	}
}