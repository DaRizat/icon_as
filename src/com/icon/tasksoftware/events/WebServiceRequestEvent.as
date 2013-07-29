package com.icon.tasksoftware.events
{
	import com.icon.tasksoftware.data.WebServiceRequest;
	
	import starling.events.Event;
	
	public class WebServiceRequestEvent extends Event
	{
		public static var REQUEST:String = "REQUEST";
		
		public function WebServiceRequestEvent(data:WebServiceRequest)
		{
			super(REQUEST, false, data);
		}
	}
}