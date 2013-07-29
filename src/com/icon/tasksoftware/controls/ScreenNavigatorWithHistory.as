package com.icon.tasksoftware.controls
{
	import feathers.controls.ScreenNavigator;
	
	import starling.display.DisplayObject;
	
	public class ScreenNavigatorWithHistory extends ScreenNavigator
	{
		private var _history:Vector.<String>;
		
		private var _main:Main;
		
		public function ScreenNavigatorWithHistory(main:Main)
		{
			super();
			
			_main = main;
			
			_history = new Vector.<String>;
		}
		
		public function showScreenWithoutHistory(id:String):DisplayObject
		{
			return super.showScreen(id);
		}
		
		override public function showScreen(id:String):DisplayObject
		{
			_history.push(id);
			return super.showScreen(id);
		}
		
		public function goBack(item:Object):void
		{
			if (_history.length > 1) {
				_history.pop();
				
				_main.ShowScreen(_history[_history.length - 1], item)
			}
		}
		
		public function clearHistory():void
		{
			_history = new Vector.<String>;
		}
	}
}