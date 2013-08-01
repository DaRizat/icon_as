package com.icon.tasksoftware.controls
{
	import com.icon.tasksoftware.events.ApplicationEvent;
	import com.icon.tasksoftware.events.EventHub;
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.popups.CalloutPopUpContentManager;
	import feathers.controls.popups.IPopUpContentManager;
	import feathers.controls.popups.VerticalCenteredPopUpContentManager;
	import feathers.data.ListCollection;
	import feathers.system.DeviceCapabilities;
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class DropDownHeader extends Header
	{
		public static const DEFAULT_CHILD_NAME_LIST:String = "feathers-picker-list-list";
		
		public static const ORGANIZATIONS:String = "Organizations";
		public static const ROLES:String = "Roles";
		public static const TASKS:String = "Tasks";
		public static const TEAMS:String = "Teams";
		public static const USERS:String = "Users";
		
		private var _dropdownButton:Button;
		private var _list:List;
		
		protected var _hasBeenScrolled:Boolean = false;
		protected var _dataProvider:ListCollection;
		protected var _popUpContentManager:IPopUpContentManager;
		
		protected var _typicalItemWidth:Number = NaN;
		protected var _typicalItemHeight:Number = NaN;
		protected var _typicalItem:Object = null;
		
		protected var _listTouchPointID:int = -1;
		
		private static const HELPER_TOUCHES_VECTOR:Vector.<Touch> = new <Touch>[];
		
		protected var _selectedIndex:int = -1;
		
		public function DropDownHeader(defaultTitle:String)
		{
			super();
			
			title = defaultTitle;
			
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		override protected function draw():void
		{
			super.draw();
			
			_dropdownButton.width = _titleRenderer.width + 64;
			_dropdownButton.height = this.height - 32;
			_dropdownButton.y = 16;
			_dropdownButton.x = _titleRenderer.x - 32;
			
			const dataInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_DATA);
			const stylesInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_STYLES);
			const stateInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_STATE);
			const selectionInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_SELECTED);
			var sizeInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_SIZE);
			
			if(stylesInvalid)
			{
				_typicalItemWidth = NaN;
				_typicalItemHeight = NaN;
			}
			
			if(dataInvalid)
			{
				_list.dataProvider = _dataProvider;
				_hasBeenScrolled = false;
			}
			
			if(selectionInvalid)
			{
				_list.selectedIndex = _selectedIndex;
			}
			
			sizeInvalid = autoSizeIfNeeded() || sizeInvalid;
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			_dropdownButton = new Button();
			_dropdownButton.alpha = 0;
			_dropdownButton.addEventListener(Event.TRIGGERED, onTriggered);
			addChild(_dropdownButton);
			
			if(!_list)
			{
				_list = new List();
				_list.itemRendererProperties.labelField = "name";
				_list.nameList.add(DEFAULT_CHILD_NAME_LIST);
				_list.addEventListener(Event.SCROLL, list_scrollHandler);
				_list.addEventListener(Event.CHANGE, list_changeHandler);
				_list.addEventListener(TouchEvent.TOUCH, list_touchHandler);
			}
			
			if(!this._popUpContentManager)
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
			
			dataProvider = new ListCollection(
			[
				{ name: ORGANIZATIONS },
				{ name: ROLES },
				{ name: TASKS },
				{ name: TEAMS },
				{ name: USERS }
			]);
			
			addEventListener(Event.CHANGE, onChange);
		}
		
		public function onTriggered(e:Event):void
		{
			if(_list.stage)
			{
				closePopUpList();
				return;
			}
			_popUpContentManager.open(_list, this);
			_list.scrollToDisplayIndex(_selectedIndex);
			_list.validate();
			
			_hasBeenScrolled = false;
		}
		
		public function onChange(e:Event):void
		{
			EventHub.instance.dispatchEvent(new ApplicationEvent(ApplicationEvent.CHANGE_MODEL, false, _dataProvider.getItemAt(_selectedIndex).name));
		}
		
		protected function closePopUpList():void
		{
			_list.validate();
			_popUpContentManager.close();
		}
		
		protected function list_changeHandler(event:Event):void
		{
			selectedIndex = _list.selectedIndex;
		}
		
		protected function list_scrollHandler(event:Event):void
		{
			if(_listTouchPointID >= 0)
			{
				_hasBeenScrolled = true;
			}
		}
		
		protected function removedFromStageHandler(event:Event):void
		{
			_listTouchPointID = -1;
		}
		
		protected function list_touchHandler(event:TouchEvent):void
		{
			if(!_isEnabled)
			{
				_listTouchPointID = -1;
				return;
			}
			const touches:Vector.<Touch> = event.getTouches(_list, null, HELPER_TOUCHES_VECTOR);
			if(touches.length == 0)
			{
				HELPER_TOUCHES_VECTOR.length = 0;
				return;
			}
			if(_listTouchPointID >= 0)
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
					if(!_hasBeenScrolled)
					{
						closePopUpList();
					}
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
						_hasBeenScrolled = false;
						break;
					}
				}
			}
			HELPER_TOUCHES_VECTOR.length = 0;
		}
		
		public function get dataProvider():ListCollection { return _dataProvider; }
		public function set dataProvider(value:ListCollection):void
		{
			if(_dataProvider == value)
			{
				return;
			}
			_dataProvider = value;
			if(!_dataProvider || _dataProvider.length == 0)
			{
				_selectedIndex = -1;
			}
			else if(_selectedIndex < 0)
			{
				var match:int = 0;
				
				for(var i:int = 0; i < _dataProvider.length; i++)
				{
					if(_dataProvider.getItemAt(i).name == title)
					{
						match = i;
					}
				}
				
				_selectedIndex = match;
			}
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		public function get selectedIndex():int { return _selectedIndex; }
		public function set selectedIndex(value:int):void
		{
			if(_selectedIndex == value)
			{
				return;
			}
			_selectedIndex = value;
			invalidate(INVALIDATION_FLAG_SELECTED);
			dispatchEventWith(Event.CHANGE);
		}
		
		public function get selectedItem():Object
		{
			if(!_dataProvider)
			{
				return null;
			}
			return _dataProvider.getItemAt(_selectedIndex);
		}
		
		public function set selectedItem(value:Object):void
		{
			if(!_dataProvider)
			{
				_selectedIndex = -1;
				return;
			}
			
			_selectedIndex = _dataProvider.getItemIndex(value);
		}
		
		public function get typicalItem():Object { return _typicalItem; }
		public function set typicalItem(value:Object):void
		{
			if(_typicalItem == value)
			{
				return;
			}
			_typicalItem = value;
			invalidate(INVALIDATION_FLAG_STYLES);
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
	}
}