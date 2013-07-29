package com.icon.tasksoftware.data
{
	import com.icon.tasksoftware.controls.ApplicationScreen;
	import com.icon.tasksoftware.events.EventHub;
	import com.icon.tasksoftware.events.WebServiceRequestEvent;
	import com.icon.tasksoftware.events.WebServiceResponseEvent;
	
	import flash.events.EventDispatcher;
	
	public class WebServiceManager extends EventDispatcher
	{
		public static var use_mock_data:Boolean = true;
		public static var use_mock_delay:Boolean = true;
		
		private var _main:Main;
		
		public function WebServiceManager(input:Class = null)
		{
			if(input == SingletonLock)
			{
				super(null);
			}
		}
		
		private static var _instance:WebServiceManager;
		public static function get instance():WebServiceManager
		{
			if(!_instance)
			{
				_instance = new WebServiceManager(SingletonLock)
			}
			
			return _instance;
		}
		
		public function init(main:Main):void
		{
			_main = main;
			
			EventHub.instance.addEventListener(WebServiceRequestEvent.REQUEST, onWebServiceRequest);
		}
		
		private function onWebServiceRequest(e:WebServiceRequestEvent):void
		{
			var call:WebServiceCall = new WebServiceCall(e.data as WebServiceRequest, this);
		}
		
		public function onWebServiceResponse(response:WebServiceResponse, status:String, call:WebServiceCall):void
		{
			var screen:ApplicationScreen = _main.GetScreen(response.screen);
			if(screen)
			{
				screen.dispatchEvent(new WebServiceResponseEvent(response, status));
			}
			
			call = null;
		}
	}
}

internal class SingletonLock{}