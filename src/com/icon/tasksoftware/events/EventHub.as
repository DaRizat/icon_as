package com.icon.tasksoftware.events
{
	import starling.events.EventDispatcher;
	import starling.events.Event;
	
	public class EventHub extends EventDispatcher
	{
		public function EventHub(input:Class = null)
		{
			if(input == SingletonLock)
			{
				super();
			}
		}
		
		private static var _instance:EventHub;
		public static function get instance():EventHub
		{
			if(!_instance)
			{
				_instance = new EventHub(SingletonLock)
			}
			
			return _instance;
		}
		
		public function init():void
		{
			// do nothing
		}
		
		public function relay(e:Event):void
		{
			dispatchEvent(e);
		}
	}
}

internal class SingletonLock{}