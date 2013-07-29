package com.icon.tasksoftware.data
{
	import flash.net.URLRequestMethod;

	public class WebServiceRequest
	{	
		private var _endpoint:String;
		private var _screen:String;
		private var _data:Object;
		private var _id:String;
		private var _method:String;
		
		public function WebServiceRequest(endpoint:String, screen:String, data:Object = null, id:String = "", method:String = URLRequestMethod.GET)
		{
			_endpoint = endpoint;
			_screen = screen;
			_data = data;
			_id = id;
			_method = method;
		}
		
		public function get endpoint():String { return _endpoint; }
		public function get screen():String { return _screen; }
		public function get data():Object { return _data; }
		public function get id():Object { return _id; }
		public function get method():String { return _method; }
	}
}