package com.icon.tasksoftware.controls
{
	import com.icon.tasksoftware.controls.data.DialogData;
	import com.icon.tasksoftware.events.ApplicationEvent;
	import com.icon.tasksoftware.events.WebServiceResponseEvent;
	
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.controls.popups.CalloutPopUpContentManager;
	import feathers.controls.popups.IPopUpContentManager;
	import feathers.controls.popups.VerticalCenteredPopUpContentManager;
	import feathers.system.DeviceCapabilities;
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class ApplicationScreen extends Screen
	{
		protected var _screen_name:String = "";
		
		protected var _dialog:DialogBox;
		protected var _popUpContentManager:IPopUpContentManager;
		
		protected var _listTouchPointID:int = -1;
		
		private static const HELPER_TOUCHES_VECTOR:Vector.<Touch> = new <Touch>[];
		
		public function ApplicationScreen()
		{
			addEventListener(WebServiceResponseEvent.STATUS_SUCCESS, onWebServiceResponse);
			addEventListener(WebServiceResponseEvent.STATUS_FAILURE, onWebServiceResponse);
			
			addEventListener(ApplicationEvent.DIALOG_OPEN, openPopUpDialog);
			addEventListener(ApplicationEvent.DIALOG_CLOSE, closePopUpDialog);
			
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			if(!_popUpContentManager)
			{
				if(DeviceCapabilities.isTablet(Starling.current.nativeStage))
				{
					popUpContentManager = new CalloutPopUpContentManager();
				}
				else
				{
					popUpContentManager = new VerticalCenteredPopUpContentManager();
				}
			}
		}
		
		public function openPopUpDialog(e:Event):void
		{
			if(_dialog && _dialog.stage)
			{
				closePopUpDialog();
				return;
			}
			
			if(!_dialog)
			{
				_dialog = new DialogBox(e.data as DialogData);
				_dialog.addEventListener(TouchEvent.TOUCH, dialog_touchHandler);
			}
			
			_popUpContentManager.open(_dialog, this);
			_dialog.validate();
		}
		
		protected function closePopUpDialog(e:Event = null):void
		{
			_popUpContentManager.close();
			_dialog = null;
		}
		
		protected function dialog_touchHandler(event:TouchEvent):void
		{
			if(!_isEnabled)
			{
				_listTouchPointID = -1;
				return;
			}
			const touches:Vector.<Touch> = event.getTouches(_dialog, null, HELPER_TOUCHES_VECTOR);
			if(touches.length == 0)
			{
				HELPER_TOUCHES_VECTOR.length = 0;
				return;
			}
			if(this._listTouchPointID >= 0)
			{
				var touch:Touch;
				for each(var currentTouch:Touch in touches)
				{
					if(currentTouch.id == _listTouchPointID)
					{
						touch = currentTouch;
						break;
					}
				}
				if(!touch)
				{
					HELPER_TOUCHES_VECTOR.length = 0;
					return;
				}
				if(touch.phase == TouchPhase.ENDED)
				{
					closePopUpDialog();
					_listTouchPointID = -1;
				}
			}
			else
			{
				for each(touch in touches)
				{
					if(touch.phase == TouchPhase.BEGAN)
					{
						_listTouchPointID = touch.id;
						break;
					}
				}
			}
			HELPER_TOUCHES_VECTOR.length = 0;
		}
		
		public function get popUpContentManager():IPopUpContentManager { return _popUpContentManager; }
		public function set popUpContentManager(value:IPopUpContentManager):void
		{
			if(_popUpContentManager == value)
			{
				return;
			}
			_popUpContentManager = value;
			invalidate(INVALIDATION_FLAG_STYLES);
		}
		
		public function get screen_name():String { return _screen_name; }
		public function set screen_name(value:String):void
		{
			if(_screen_name == value)
			{
				return;
			}
			_screen_name = value;
		}
		
		public function onWebServiceResponse(event:WebServiceResponseEvent):void
		{
			// override with screen-specifict functionality
		}
	}
}