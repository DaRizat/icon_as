package com.icon.tasksoftware.screens.tasks
{
	import com.icon.tasksoftware.controls.ApplicationScreen;
	import com.icon.tasksoftware.controls.DropDownHeader;
	import com.icon.tasksoftware.controls.components.ListItem;
	import com.icon.tasksoftware.controls.data.DialogButton;
	import com.icon.tasksoftware.controls.data.DialogData;
	import com.icon.tasksoftware.data.WebServiceEndpoints;
	import com.icon.tasksoftware.data.WebServiceRequest;
	import com.icon.tasksoftware.data.WebServiceResponse;
	import com.icon.tasksoftware.data.models.Task;
	import com.icon.tasksoftware.data.models.Task;
	import com.icon.tasksoftware.events.ApplicationEvent;
	import com.icon.tasksoftware.events.EventHub;
	import com.icon.tasksoftware.events.WebServiceRequestEvent;
	import com.icon.tasksoftware.events.WebServiceResponseEvent;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import feathers.layout.VerticalLayout;
	
	import starling.events.Event;
	
	public class TaskIndex extends ApplicationScreen
	{	
		private var task_data:Vector.<Task>;
		private var selectedTask:Task;
		
		private var header:DropDownHeader;
		private var newButton:Button;
		private var list:List;
		
		private var buttonEdit:Boolean = false;
		private var buttonDelete:Boolean = false;
		
		public function TaskIndex()
		{
			super();
			screen_name = Main.TASK_INDEX;
			
			addEventListener(Event.ADDED_TO_STAGE, reset);
		}
		
		private function reset(e:Event):void
		{
			task_data = null;
			
			var request:WebServiceRequest = new WebServiceRequest(WebServiceEndpoints.TASK_INDEX, screen_name);
			EventHub.instance.relay(new WebServiceRequestEvent(request));
			
			drawList();
		}
		
		override protected function draw():void
		{
			header.width = actualWidth;
			
			newButton.width = actualWidth - 36;
			newButton.height = 64;
			newButton.y = actualHeight - newButton.height - 18;
			newButton.x = 18;
			
			list.y = header.height + 18;
			list.x = 18;
			list.width = actualWidth - 36;
			list.height = actualHeight - header.height - newButton.height - 54;
			
			if(task_data)
			{
				drawList();
			}
		}
		
		override public function onWebServiceResponse(event:WebServiceResponseEvent):void
		{
			if(event.type == WebServiceResponseEvent.STATUS_SUCCESS)
			{
				var response:WebServiceResponse = event.data as WebServiceResponse;
				switch(response.endpoint)
				{
					case WebServiceEndpoints.TASK_INDEX:
						task_data = response.data as Vector.<Task>;
						drawList();
						break;
					case WebServiceEndpoints.TASK_DESTROY:
						for(var i:int = 0; i < task_data.length; i++)
						{
							if(task_data[i].id == Task(response.data).id)
							{
								task_data.splice(i, 1);
								drawList();
								break;
							}
						}
						break;
				}
			}
			else
			{
				// TODO: handle web service errors
			}
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			buttonEdit = false;
			buttonDelete = false;
			
			header = new DropDownHeader(DropDownHeader.TASKS);
			addChild(header);
			
			newButton = new Button();
			newButton.label = "Create New Task";
			newButton.addEventListener(Event.TRIGGERED, onNewButton)
			addChild(newButton);
			
			list = new List();
			addChild(list);
		}
		
		protected function done(e:WebServiceResponseEvent = null):void
		{
			task_data = JSON.parse(e.data as String) as Vector.<Task>;
			drawList();
		}
		
		private function drawList():void
		{
			buttonEdit = false;
			buttonDelete = false;
			
			list.dataProvider = new ListCollection(task_data);
			list.addEventListener(Event.CHANGE, listChanged);
			list.addEventListener("edit", listEdit);
			list.addEventListener("delete", listDelete);
			list.itemRendererType = ListItem;
			VerticalLayout(list.layout).gap = 24;
		}
		
		private function listChanged(e:Event):void
		{
			if(list.selectedIndex >= 0)
			{
				selectedTask = Task(list.selectedItem);
				
				if(buttonEdit)
				{
					dispatchEventWith("taskEdit", false, selectedTask);
				}
				else if(buttonDelete)
				{
					var dialogButtons:Vector.<DialogButton> = new Vector.<DialogButton>();
					dialogButtons.push(new DialogButton("OK", deleteTask));
					dialogButtons.push(new DialogButton("Cancel", closePopUpDialog));
					dispatchEvent(new ApplicationEvent(ApplicationEvent.DIALOG_OPEN, false, new DialogData("Delete Task", "Are you sure you want to delete '" + selectedTask.name + "'?", dialogButtons)));
				}
				else
				{
					dispatchEventWith("taskShow", false, selectedTask);
				}
				
				buttonEdit = false;
				buttonDelete = false;
				
				list.selectedIndex = -1;
			}
		}
		
		private function deleteTask():void
		{
			var request:WebServiceRequest = new WebServiceRequest(WebServiceEndpoints.TASK_DESTROY, screen_name, selectedTask);
			EventHub.instance.relay(new WebServiceRequestEvent(request));
		}
		
		private function listEdit(e:Event):void
		{
			buttonEdit = true;
		}
		
		private function listDelete(e:Event):void
		{
			buttonDelete = true;
		}
		
		private function onNewButton(e:Event):void
		{
			dispatchEventWith("taskNew");
		}
	}
}