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
	import feathers.controls.TextInput;
	import feathers.themes.IconMobileTheme;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class TaskEdit extends ApplicationScreen
	{
		
		private var header:DropDownHeader;
		private var backButton:Button;
		
		private var nameLabel:Label;
		private var nameInput:TextInput;
		private var descriptionLabel:Label;
		private var descriptionInput:TextInput;
		private var imageLabel:Label;
		private var imageInput:TextInput;
		private var qrCodeLabel:Label;
		private var qrCodeInput:TextInput;
		
		private var cancelButton:Button;
		private var submitButton:Button;
		
		private var _task:Task;
		private var _task_id:String;
		
		public function TaskEdit()
		{
			super();
			screen_name = Main.TASK_EDIT;
			
			addEventListener(Event.ADDED_TO_STAGE, reset);
		}
		
		private function reset(e:Event):void
		{
			task = null;
			
			nameInput.text = "";
			nameInput.isEnabled = false;
			descriptionInput.text = "";
			descriptionInput.isEnabled = false;
			imageInput.text = "";
			imageInput.isEnabled = false;
			qrCodeInput.text = "";
			qrCodeInput.isEnabled = false;
			
			cancelButton.isEnabled = false;
			submitButton.isEnabled = false;
			
			var request:WebServiceRequest = new WebServiceRequest(WebServiceEndpoints.construct(WebServiceEndpoints.TASK_READ, {task:task_id}), screen_name);
			EventHub.instance.relay(new WebServiceRequestEvent(request));
		}
		
		override protected function draw():void
		{
			header.width = actualWidth;
			
			nameLabel.x = 18;
			nameLabel.y = header.height + 18;
			nameLabel.width = actualWidth - 36;
			
			nameInput.x = 18;
			nameInput.y = nameLabel.y + nameLabel.height + nameInput.paddingTop;
			nameInput.width = actualWidth - 36;
			
			descriptionLabel.x = 18;
			descriptionLabel.y = nameInput.y + 64;
			descriptionLabel.width = actualWidth - 36;
			
			descriptionInput.x = 18;
			descriptionInput.y = descriptionLabel.y + 36;
			descriptionInput.width = actualWidth - 36;
			
			imageLabel.x = 18;
			imageLabel.y = descriptionInput.y + 64;
			imageLabel.width = actualWidth - 36;
			
			imageInput.x = 18;
			imageInput.y = imageLabel.y + 36;
			imageInput.width = actualWidth - 36;
			
			qrCodeLabel.x = 18;
			qrCodeLabel.y = imageInput.y + 64;
			qrCodeLabel.width = actualWidth - 36;
			
			qrCodeInput.x = 18;
			qrCodeInput.y = qrCodeLabel.y + 36;
			qrCodeInput.width = actualWidth - 36;
			
			if(task)
			{
				nameInput.text = task.name;
				descriptionInput.text = task.description;
				imageInput.text = task.image;
				qrCodeInput.text = task.qr_code;
			}
			
			cancelButton.width = (actualWidth - 54) / 2.0;
			cancelButton.height = 64;
			cancelButton.x = 18;
			cancelButton.y = actualHeight - cancelButton.height - 18;
			
			submitButton.width = (actualWidth - 54) / 2.0;
			submitButton.height = 64;
			submitButton.x = cancelButton.x + cancelButton.width + 18;
			submitButton.y = actualHeight - submitButton.height - 18;
		}
		
		override public function onWebServiceResponse(event:WebServiceResponseEvent):void
		{
			if(event.type == WebServiceResponseEvent.STATUS_SUCCESS)
			{
				var response:WebServiceResponse = event.data as WebServiceResponse;
				switch(response.endpoint)
				{
					case WebServiceEndpoints.TASK_UPDATE:
						dispatchEventWith("back", false, task);
						break;
					case WebServiceEndpoints.TASK_READ:
						task = Task(response.data);
						nameInput.text = task.name;
						descriptionInput.text = task.description;
						imageInput.text = task.image;
						qrCodeInput.text = task.qr_code;
						
						nameInput.isEnabled = true;
						descriptionInput.isEnabled = true;
						imageInput.isEnabled = true;
						qrCodeInput.isEnabled = true;
						cancelButton.isEnabled = true;
						submitButton.isEnabled = true;
						
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
			
			nameLabel = new Label();
			nameLabel.text = "Name:";
			addChild(nameLabel);
			
			nameInput = new TextInput();
			addChild(nameInput);
			
			descriptionLabel = new Label();
			descriptionLabel.text = "Description:";
			addChild(descriptionLabel);
			
			descriptionInput = new TextInput();
			addChild(descriptionInput);
			
			imageLabel = new Label();
			imageLabel.text = "Image:";
			addChild(imageLabel);
			
			imageInput = new TextInput();
			addChild(imageInput);
			
			qrCodeLabel = new Label();
			qrCodeLabel.text = "QR Code:";
			addChild(qrCodeLabel);
			
			qrCodeInput = new TextInput();
			addChild(qrCodeInput);
			
			cancelButton = new Button();
			cancelButton.label = "Cancel";
			cancelButton.addEventListener(Event.TRIGGERED, onCancel);
			addChild(cancelButton);
			
			submitButton = new Button();
			submitButton.label = "OK";
			submitButton.addEventListener(Event.TRIGGERED, onSubmit);
			addChild(submitButton);
		}
		
		private function onBack(e:Event):void
		{
			dispatchEventWith("back", false, task);
		}
		
		private function onCancel(e:Event):void
		{
			dispatchEventWith("back", false, task);
		}
		
		private function onSubmit(e:Event):void
		{
			nameInput.isEnabled = false;
			cancelButton.isEnabled = false;
			submitButton.isEnabled = false;
			
			// TODO: validate input
			
			task.name = nameInput.text;
			task.completed = false;
			task.description = descriptionInput.text;
			task.image = imageInput.text;
			task.qr_code = qrCodeInput.text;
			var request:WebServiceRequest = new WebServiceRequest(WebServiceEndpoints.TASK_UPDATE, screen_name, task);
			EventHub.instance.relay(new WebServiceRequestEvent(request));
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