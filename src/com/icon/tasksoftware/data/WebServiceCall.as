package com.icon.tasksoftware.data
{
	import com.icon.tasksoftware.Faker.Faker;
	import com.icon.tasksoftware.events.WebServiceResponseEvent;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.utils.setTimeout;
	
	import starling.events.EventDispatcher;

	public class WebServiceCall extends EventDispatcher
	{
		private var _url_base:String = "http://www.kongregate.com/api/";
		private var _request:WebServiceRequest;
		private var _manager:WebServiceManager;
		
		public function WebServiceCall(request:WebServiceRequest, manager:WebServiceManager)
		{
			_request = request;
			_manager = manager;
			
			if(WebServiceManager.use_mock_data)
			{
				if(WebServiceManager.use_mock_delay)
				{
					setTimeout(SendResponse, 500 + Math.random() * 2500);
				}
				else
				{
					SendResponse();
				}
			}
			else
			{
				var vars:URLVariables = new URLVariables();
				if(request.data) vars.data = JSON.stringify(request.data);
				
				// TODO: regx {id} into endpoint
				var urlReq:URLRequest = new URLRequest(request.endpoint);
				urlReq.method = request.method;
				urlReq.data = vars;
				
				var urlLoader:URLLoader = new URLLoader();
				urlLoader.addEventListener(Event.COMPLETE, onWebServiceResponse);
				urlLoader.load(urlReq);
			}
		}
		
		protected function onWebServiceResponse(e:Event):void
		{
			// TODO: handle web service failure
			
			SendResponse(JSON.parse(e.currentTarget.data));
		}
		
		private function SendResponse(data:Object = null):void
		{
			if(!data && WebServiceManager.use_mock_delay)
			{
				data = Faker.instance.GenerateResponse(_request);
			}
			
			var response:WebServiceResponse = new WebServiceResponse(data, _request.screen);
			var status:String = WebServiceResponseEvent.STATUS_SUCCESS;
			
			_manager.onWebServiceResponse(response, status, this);
		}
	}
}