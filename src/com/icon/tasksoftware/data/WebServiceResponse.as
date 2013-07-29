package com.icon.tasksoftware.data
{
	public class WebServiceResponse
	{
		private var _data:Object;
		private var _screen:String;
		
		public function WebServiceResponse(data:Object, screen:String)
		{
			_data = data;
			_screen = screen;
		}
		
		public function get data():Object { return _data; }
		public function get screen():String { return _screen; }
	}
}