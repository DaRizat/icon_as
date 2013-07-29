package com.icon.tasksoftware.events
{
	import com.icon.tasksoftware.data.WebServiceResponse;
	
	import starling.events.Event;
	
	public class WebServiceResponseEvent extends Event
	{
		public static var STATUS_SUCCESS:String = "STATUS_SUCCESS";
		public static var STATUS_FAILURE:String = "STATUS_FAILURE";
		
		public function WebServiceResponseEvent(data:WebServiceResponse, type:String = "STATUS_SUCCESS")
		{
			super(type, false, data);
		}
	}
}