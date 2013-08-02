package com.icon.tasksoftware.controls
{
	import com.icon.tasksoftware.controls.data.DialogData;
	
	import feathers.controls.ButtonGroup;
	import feathers.controls.Label;
	import feathers.controls.renderers.BaseDefaultItemRenderer;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.FeathersControl;
	import feathers.data.ListCollection;
	import feathers.themes.IconMobileTheme;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class DialogBox extends FeathersControl
	{
		private var _data:DialogData;
		
		private var title:Label;
		private var description:TextFieldTextRenderer;
		private var buttons:ButtonGroup;
		
		protected var _backgroundSkin:DisplayObject;
		
		public static const TITLE_LABEL:String = "dialog-box-title-label";
		public static const DESCRIPTION_LABEL:String = "dialog-box-description-label";
		
		public function DialogBox(data:DialogData)
		{
			super();
			
			_data = data;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		override protected function draw():void
		{
			title.width = actualWidth * 0.8;
			title.x = actualWidth * 0.1;
			title.y = backgroundSkin.y + 18;
			
			description.width = actualWidth * 0.6;
			description.x = actualWidth * 0.2;
			description.y = (actualHeight / 10.0) * 4;
			
			buttons.width = actualWidth * 0.6;
			buttons.x = actualWidth * 0.2;
			buttons.y = (actualHeight / 10.0) * 6;
		}
		
		override protected function initialize():void
		{
			title = new Label();
			title.nameList.add(TITLE_LABEL);
			title.text = data.title;
			addChild(title);
			
			description = new TextFieldTextRenderer();
			description.wordWrap = true;
			description.nameList.add(DESCRIPTION_LABEL);
			description.text = data.description;
			addChild(description);
			
			buttons = new ButtonGroup();
			buttons.direction = ButtonGroup.DIRECTION_HORIZONTAL;
			var buttonsData:ListCollection = new ListCollection();
			for(var i:int = 0; i < data.buttons.length; i++)
			{
				buttonsData.push({label:data.buttons[i].label, triggered:data.buttons[i].callback});
			}
			buttons.dataProvider = buttonsData;
			addChild(buttons);
		}
		
		private function onAddedToStage(e:Event):void
		{
			width = stage.width;
			height = stage.height;
		}
		
		public function get data():DialogData { return _data; }
		public function set data(value:DialogData):void
		{
			_data = value;
		}
		
		public function get backgroundSkin():DisplayObject { return _backgroundSkin; }
		public function set backgroundSkin(value:DisplayObject):void
		{
			if(_backgroundSkin == value)
			{
				return;
			}
			
			if(_backgroundSkin)
			{
				removeChild(_backgroundSkin);
			}
			_backgroundSkin = value;
			if(_backgroundSkin && _backgroundSkin.parent != this)
			{
				_backgroundSkin.visible = true;
				_backgroundSkin.touchable = true;
				addChildAt(_backgroundSkin, 0);
			}
			this.invalidate(INVALIDATION_FLAG_STYLES);
		}
	}
}