package com.icon.tasksoftware.data
{
	public class WebServiceResponse
	{
		private var _endpoint:String;
		private var _data:Object;
		private var _screen:String;
		
		public function WebServiceResponse(endpoint:String, data:Object, screen:String)
		{
			_endpoint = endpoint;
			_data = data;
			_screen = screen;
		}
		
		public function get endpoint():String { return _endpoint; }
		public function get data():Object { return _data; }
		public function get screen():String { return _screen; }
	}
}