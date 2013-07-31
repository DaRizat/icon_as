package com.icon.tasksoftware.events
{
	import starling.events.Event;
	
	public class ApplicationEvent extends Event
	{
		public static var CHANGE_MODEL:String = "CHANGE_MODEL";
		
		public function ApplicationEvent(type:String, bubbles:Boolean = false, data:Object = null)
		{
			super(type, false, data);
		}
	}
}