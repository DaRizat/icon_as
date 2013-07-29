package com.icon.tasksoftware.screens.organizations.components
{
	import com.icon.tasksoftware.data.models.Organization;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.renderers.DefaultListItemRenderer;
	
	import starling.events.Event;
	
	public class OrganizationListItem extends DefaultListItemRenderer
	{
		private var itemLabel:Label;
		private var editButton:Button;
		private var deleteButton:Button;
		
		private var _object_id:String;
		
		public static const STATE_UP:String = "up";
		public static const STATE_DOWN:String = "down";
		public static const STATE_HOVER:String = "hover";
		public static const STATE_DISABLED:String = "disabled";
		
		public function OrganizationListItem()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			if(!itemLabel)
			{
				itemLabel = new Label();
				addChild(itemLabel);
			}
			if(!editButton)
			{
				editButton = new Button();
				editButton.label = "edit";
				editButton.addEventListener(Event.TRIGGERED, onEditButtonTrigger);
				addChild(editButton);
			}
			if(!deleteButton)
			{
				deleteButton = new Button();
				// TODO: replace "x" with texture icon
				deleteButton.label = "x";
				deleteButton.addEventListener(Event.TRIGGERED, onDeleteButtonTrigger);
				addChild(deleteButton);
			}
			
			addEventListener(Event.ADDED, onAdded);
		}
		
		private function onAdded(e:Event):void
		{
			owner = this.parent as List;
		}
		
		private function onEditButtonTrigger(e:Event):void
		{
			dispatchEventWith("edit", true);
		}
		
		private function onDeleteButtonTrigger(e:Event):void
		{
			dispatchEventWith("delete", true);
		}
		
		override protected function draw():void
		{
			super.draw();
			
			const dataInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_DATA);
			const selectionInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_SELECTED);
			var sizeInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_SIZE);
			
			if(dataInvalid)
			{
				this.commitData();
			}
			
			sizeInvalid = this.autoSizeIfNeeded() || sizeInvalid;
			
			if(dataInvalid || sizeInvalid)
			{
				this.layout();
			}
		}
		
		override protected function autoSizeIfNeeded():Boolean
		{
			const needsWidth:Boolean = isNaN(this.explicitWidth);
			const needsHeight:Boolean = isNaN(this.explicitHeight);
			
			if(!needsWidth && !needsHeight)
			{
				return false;
			}
			
			itemLabel.width = NaN;
			itemLabel.height = NaN;
			itemLabel.validate();
			
			editButton.width = NaN;
			editButton.height = NaN;
			editButton.validate();
			
			deleteButton.width = NaN;
			deleteButton.height = NaN;
			deleteButton.validate();
			
			var newWidth:Number = this.explicitWidth;
			if(needsWidth)
			{
				newWidth = itemLabel.width + editButton.width + deleteButton.width;
			}
			
			var newHeight:Number = this.explicitHeight;
			if(needsHeight)
			{
				newHeight = Math.max(itemLabel.height, editButton.height, deleteButton.height);
			}
			
			return this.setSizeInternal(newWidth, newHeight, false);
		}
		
		override protected function commitData():void
		{
			super.commitData();
			
			if(_data)
			{
				itemLabel.text = Organization(_data).name;
				object_id = Organization(_data).id;
			}
			else
			{
				itemLabel.text = "";
			}
		}
		
		protected function layout():void
		{
			itemLabel.width = actualWidth - itemLabel.x - editButton.width - editButton.paddingLeft - editButton.paddingRight - deleteButton.width - deleteButton.paddingLeft - deleteButton.paddingRight;
			itemLabel.y = (actualHeight - itemLabel.height) / 2.0;
			
			deleteButton.x = actualWidth - deleteButton.width - deleteButton.paddingRight;
			
			editButton.x = deleteButton.x - editButton.width - editButton.paddingRight;
		}
		
		// GET/SET functions
		
		public function get object_id():String { return _object_id; }
		public function set object_id(value:String):void
		{
			_object_id = value;
		}
	}
}