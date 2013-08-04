package com.icon.tasksoftware.screens.users
{
	import com.icon.tasksoftware.controls.ApplicationScreen;
	import com.icon.tasksoftware.controls.DropDownHeader;
	import com.icon.tasksoftware.controls.components.ListItem;
	import com.icon.tasksoftware.controls.data.DialogButton;
	import com.icon.tasksoftware.controls.data.DialogData;
	import com.icon.tasksoftware.data.WebServiceEndpoints;
	import com.icon.tasksoftware.data.WebServiceRequest;
	import com.icon.tasksoftware.data.WebServiceResponse;
	import com.icon.tasksoftware.data.models.User;
	import com.icon.tasksoftware.data.models.User;
	import com.icon.tasksoftware.events.ApplicationEvent;
	import com.icon.tasksoftware.events.EventHub;
	import com.icon.tasksoftware.events.WebServiceRequestEvent;
	import com.icon.tasksoftware.events.WebServiceResponseEvent;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import feathers.layout.VerticalLayout;
	
	import starling.events.Event;
	
	public class UserIndex extends ApplicationScreen
	{	
		private var user_data:Vector.<User>;
		private var selectedUser:User;
		
		private var header:DropDownHeader;
		private var newButton:Button;
		private var list:List;
		
		private var buttonEdit:Boolean = false;
		private var buttonDelete:Boolean = false;
		
		public function UserIndex()
		{
			super();
			screen_name = Main.USER_INDEX;
			
			addEventListener(Event.ADDED_TO_STAGE, reset);
		}
		
		private function reset(e:Event):void
		{
			user_data = null;
			
			var request:WebServiceRequest = new WebServiceRequest(WebServiceEndpoints.USER_INDEX, screen_name);
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
			
			if(user_data)
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
					case WebServiceEndpoints.USER_INDEX:
						user_data = response.data as Vector.<User>;
						drawList();
						break;
					case WebServiceEndpoints.USER_DESTROY:
						for(var i:int = 0; i < user_data.length; i++)
						{
							if(user_data[i].id == User(response.data).id)
							{
								user_data.splice(i, 1);
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
			
			header = new DropDownHeader(DropDownHeader.USERS);
			addChild(header);
			
			newButton = new Button();
			newButton.label = "Create New User";
			newButton.addEventListener(Event.TRIGGERED, onNewButton)
			addChild(newButton);
			
			list = new List();
			addChild(list);
		}
		
		protected function done(e:WebServiceResponseEvent = null):void
		{
			user_data = JSON.parse(e.data as String) as Vector.<User>;
			drawList();
		}
		
		private function drawList():void
		{
			buttonEdit = false;
			buttonDelete = false;
			
			list.dataProvider = new ListCollection(user_data);
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
				selectedUser = User(list.selectedItem);
				
				if(buttonEdit)
				{
					dispatchEventWith("userEdit", false, selectedUser);
				}
				else if(buttonDelete)
				{
					var dialogButtons:Vector.<DialogButton> = new Vector.<DialogButton>();
					dialogButtons.push(new DialogButton("OK", deleteUser));
					dialogButtons.push(new DialogButton("Cancel", closePopUpDialog));
					dispatchEvent(new ApplicationEvent(ApplicationEvent.DIALOG_OPEN, false, new DialogData("Delete User", "Are you sure you want to delete '" + selectedUser.name + "'?", dialogButtons)));
				}
				else
				{
					dispatchEventWith("userShow", false, selectedUser);
				}
				
				buttonEdit = false;
				buttonDelete = false;
				
				list.selectedIndex = -1;
			}
		}
		
		private function deleteUser():void
		{
			var request:WebServiceRequest = new WebServiceRequest(WebServiceEndpoints.USER_DESTROY, screen_name, selectedUser);
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
			dispatchEventWith("userNew");
		}
	}
}