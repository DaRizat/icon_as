package com.icon.tasksoftware.screens.tasks
{
	import com.icon.tasksoftware.controls.ApplicationScreen;
	import com.icon.tasksoftware.controls.DropDownHeader;
	import com.icon.tasksoftware.data.WebServiceEndpoints;
	import com.icon.tasksoftware.data.WebServiceRequest;
	import com.icon.tasksoftware.data.WebServiceResponse;
	import com.icon.tasksoftware.data.models.Task;
	import com.icon.tasksoftware.events.EventHub;
	import com.icon.tasksoftware.events.WebServiceRequestEvent;
	import com.icon.tasksoftware.events.WebServiceResponseEvent;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.themes.IconMobileTheme;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class TaskShow extends ApplicationScreen
	{
		private var header:DropDownHeader;
		private var backButton:Button;
		
		private var taskLabel:Label;
		private var taskDescription:Label;
		private var taskComplete:Label;
		private var taskImage:Label;
		private var taskQRCode:Label;
		private var editButton:Button;
		
		private var _task:Task;
		private var _task_id:String;
		
		public function TaskShow()
		{
			super();
			screen_name = Main.TASK_SHOW;
			
			addEventListener(Event.ADDED_TO_STAGE, reset);
		}
		
		private function reset(e:Event):void
		{
			task = null;
			
			taskLabel.text = "";
			taskDescription.text = "";
			taskComplete.text = "";
			taskImage.text = "";
			taskQRCode.text = "";
			
			var request:WebServiceRequest = new WebServiceRequest(WebServiceEndpoints.construct(WebServiceEndpoints.TASK_READ, {task:task_id}), screen_name);
			EventHub.instance.relay(new WebServiceRequestEvent(request));
		}
		
		override protected function draw():void
		{
			header.width = actualWidth;
			
			taskLabel.x = 18;
			taskLabel.y = header.height + 18;
			taskLabel.width = actualWidth - 36;
			
			taskDescription.x = 18;
			taskDescription.y = taskLabel.y + 64;
			taskDescription.width = actualWidth - 36;
			
			taskComplete.x = 18;
			taskComplete.y = taskDescription.y + 64;
			taskComplete.width = actualWidth - 36;
			
			taskImage.x = 18;
			taskImage.y = taskComplete.y + 64;
			taskImage.width = actualWidth - 36;
			
			taskQRCode.x = 18;
			taskQRCode.y = taskImage.y + 64;
			taskQRCode.width = actualWidth - 36;
			
			if(task)
			{
				taskLabel.text = task.name;
				taskDescription.text = task.description;
				taskComplete.text = task.completed.toString();
				taskImage.text = task.image;
				taskQRCode.text = task.qr_code;
			}
			
			editButton.width = actualWidth - 36;
			editButton.height = 64;
			editButton.x = 18;
			editButton.y = actualHeight - editButton.height - 18;
		}
		
		override public function onWebServiceResponse(event:WebServiceResponseEvent):void
		{
			if(event.type == WebServiceResponseEvent.STATUS_SUCCESS)
			{
				var response:WebServiceResponse = event.data as WebServiceResponse;
				switch(response.endpoint)
				{
					case WebServiceEndpoints.TASK_READ:
						task = Task(response.data);
						taskLabel.text = task.name;
						taskDescription.text = task.description;
						taskComplete.text = task.completed.toString();
						taskImage.text = task.image;
						taskQRCode.text = task.qr_code;
						break;
				}
			}
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			header = new DropDownHeader(DropDownHeader.TASKS);
			addChild(header);
			
			backButton = new Button();
			backButton.label = "Back";
			backButton.nameList.add(IconMobileTheme.BACK_BUTTON);
			backButton.addEventListener(Event.TRIGGERED, onBack);
			header.leftItems = new <DisplayObject>[backButton];
			
			taskLabel = new Label();
			taskLabel.nameList.add(IconMobileTheme.PAGE_HEADER);
			addChild(taskLabel);
			
			taskDescription = new Label();
			taskDescription.nameList.add(IconMobileTheme.PAGE_HEADER);
			addChild(taskDescription);
			
			taskComplete = new Label();
			taskComplete.nameList.add(IconMobileTheme.PAGE_HEADER);
			addChild(taskComplete);
			
			taskImage = new Label();
			taskImage.nameList.add(IconMobileTheme.PAGE_HEADER);
			addChild(taskImage);
			
			taskQRCode = new Label();
			taskQRCode.nameList.add(IconMobileTheme.PAGE_HEADER);
			addChild(taskQRCode);
			
			editButton = new Button();
			editButton.label = "Edit";
			editButton.addEventListener(Event.TRIGGERED, onEdit);
			addChild(editButton);
		}
		
		private function onBack(e:Event):void
		{
			dispatchEventWith("back", false, task);
		}
		
		private function onEdit(e:Event):void
		{
			dispatchEventWith("taskEdit", false, task);
		}
		
		public function get task():Task { return _task; }
		public function set task(value:Task):void
		{
			_task = value;
			invalidate( INVALIDATION_FLAG_DATA );
		}
		
		public function get task_id():String { return _task_id; }
		public function set task_id(value:String):void
		{
			_task_id = value;
			invalidate( INVALIDATION_FLAG_DATA );
		}
	}
}