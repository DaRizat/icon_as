package com.icon.tasksoftware.screens.roles
{
	import com.icon.tasksoftware.controls.ApplicationScreen;
	import com.icon.tasksoftware.controls.DropDownHeader;
	import com.icon.tasksoftware.controls.components.ListItem;
	import com.icon.tasksoftware.controls.data.DialogButton;
	import com.icon.tasksoftware.controls.data.DialogData;
	import com.icon.tasksoftware.data.WebServiceEndpoints;
	import com.icon.tasksoftware.data.WebServiceRequest;
	import com.icon.tasksoftware.data.WebServiceResponse;
	import com.icon.tasksoftware.data.models.Role;
	import com.icon.tasksoftware.data.models.Role;
	import com.icon.tasksoftware.events.ApplicationEvent;
	import com.icon.tasksoftware.events.EventHub;
	import com.icon.tasksoftware.events.WebServiceRequestEvent;
	import com.icon.tasksoftware.events.WebServiceResponseEvent;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import feathers.layout.VerticalLayout;
	
	import starling.events.Event;
	
	public class RoleIndex extends ApplicationScreen
	{	
		private var role_data:Vector.<Role>;
		private var selectedRole:Role;
		
		private var header:DropDownHeader;
		private var newButton:Button;
		private var list:List;
		
		private var buttonEdit:Boolean = false;
		private var buttonDelete:Boolean = false;
		
		public function RoleIndex()
		{
			super();
			screen_name = Main.ROLE_INDEX;
			
			addEventListener(Event.ADDED_TO_STAGE, reset);
		}
		
		private function reset(e:Event):void
		{
			role_data = null;
			
			var request:WebServiceRequest = new WebServiceRequest(WebServiceEndpoints.ROLE_INDEX, screen_name);
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
			
			if(role_data)
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
					case WebServiceEndpoints.ROLE_INDEX:
						role_data = response.data as Vector.<Role>;
						drawList();
						break;
					case WebServiceEndpoints.ROLE_DESTROY:
						for(var i:int = 0; i < role_data.length; i++)
						{
							if(role_data[i].id == Role(response.data).id)
							{
								role_data.splice(i, 1);
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
			
			header = new DropDownHeader(DropDownHeader.ROLES);
			addChild(header);
			
			newButton = new Button();
			newButton.label = "Create New Role";
			newButton.addEventListener(Event.TRIGGERED, onNewButton)
			addChild(newButton);
			
			list = new List();
			addChild(list);
		}
		
		protected function done(e:WebServiceResponseEvent = null):void
		{
			role_data = JSON.parse(e.data as String) as Vector.<Role>;
			drawList();
		}
		
		private function drawList():void
		{
			buttonEdit = false;
			buttonDelete = false;
			
			list.dataProvider = new ListCollection(role_data);
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
				selectedRole = Role(list.selectedItem);
				
				if(buttonEdit)
				{
					dispatchEventWith("roleEdit", false, selectedRole);
				}
				else if(buttonDelete)
				{
					var dialogButtons:Vector.<DialogButton> = new Vector.<DialogButton>();
					dialogButtons.push(new DialogButton("OK", deleteRole));
					dialogButtons.push(new DialogButton("Cancel", closePopUpDialog));
					dispatchEvent(new ApplicationEvent(ApplicationEvent.DIALOG_OPEN, false, new DialogData("Delete Role", "Are you sure you want to delete '" + selectedRole.name + "'?", dialogButtons)));
				}
				else
				{
					dispatchEventWith("roleShow", false, selectedRole);
				}
				
				buttonEdit = false;
				buttonDelete = false;
				
				list.selectedIndex = -1;
			}
		}
		
		private function deleteRole():void
		{
			var request:WebServiceRequest = new WebServiceRequest(WebServiceEndpoints.ROLE_DESTROY, screen_name, selectedRole);
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
			dispatchEventWith("roleNew");
		}
	}
}