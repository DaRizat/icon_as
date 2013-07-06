package com.icon.tasksoftware.screens
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.data.ListCollection;
	import feathers.skins.StandardIcons;
	
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class TaskList extends Screen
	{
		private var header:Header;
		private var loader:URLLoader;
		private var list:List;
		
		public function TaskList()
		{
			
		}
		
		override protected function draw():void
		{
			header.width = actualWidth;
			
			list.y = header.height + 18;
			list.x = 18;
			list.width = actualWidth - 36;
			list.height = actualHeight - header.height - 36;
			
			if(Main.user_data)
			{
				drawList();
			}
		}
		
		override protected function initialize():void
		{
			header = new Header();
			addChild(header);
			
			if(!Main.user_data)
			{
				loader = new URLLoader(new URLRequest("user.json"));
				loader.addEventListener(flash.events.Event.COMPLETE, done);
			}
			
			list = new List();
			addChild(list);
		}
		
		protected function done(e:flash.events.Event = null):void
		{
			trace("PersonList.done()");
			loader.removeEventListener(flash.events.Event.COMPLETE, done);
			Main.user_data = JSON.parse(loader.data);
			drawList();
		}
		
		private function drawList():void
		{
			trace("PersonList.drawList()");
			
			list.dataProvider = new ListCollection(Main.user_data.tasks);
			list.itemRendererProperties.labelField = "name";
			list.itemRendererProperties.iconSourceFunction = Main.theme.getIcon; 
			list.itemRendererProperties.accessorySourceFunction = function(item:Object):Texture{return StandardIcons.listDrillDownAccessoryTexture;};
			list.addEventListener(starling.events.Event.CHANGE, listChanged);
			
			header.title = Main.user_data.name + " - Tasks";
		}
		
		private function listChanged(e:starling.events.Event):void
		{
			var selectedItem:Object = list.selectedItem;
			selectedItem.index = list.selectedIndex + 1;
			dispatchEventWith("listSelected", false, selectedItem);
		}
	}
}