package com.icon.tasksoftware.controls
{
	import com.icon.tasksoftware.events.WebServiceResponseEvent;
	
	import feathers.controls.Screen;
	
	public class ApplicationScreen extends Screen
	{
		protected var screen_name:String = "";
		
		public function ApplicationScreen()
		{
			addEventListener(WebServiceResponseEvent.STATUS_SUCCESS, onWebServiceResponse);
			addEventListener(WebServiceResponseEvent.STATUS_FAILURE, onWebServiceResponse);
			
			super();
		}
		
		public function onWebServiceResponse(event:WebServiceResponseEvent):void
		{
			// override with screen-specifict functionality
		}
	}
}