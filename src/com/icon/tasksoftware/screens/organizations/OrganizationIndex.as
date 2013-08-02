package com.icon.tasksoftware.screens.organizations
{
	import com.icon.tasksoftware.controls.ApplicationScreen;
	import com.icon.tasksoftware.controls.DropDownHeader;
	import com.icon.tasksoftware.controls.components.ListItem;
	import com.icon.tasksoftware.controls.data.DialogButton;
	import com.icon.tasksoftware.controls.data.DialogData;
	import com.icon.tasksoftware.data.WebServiceEndpoints;
	import com.icon.tasksoftware.data.WebServiceRequest;
	import com.icon.tasksoftware.data.WebServiceResponse;
	import com.icon.tasksoftware.data.models.Organization;
	import com.icon.tasksoftware.events.ApplicationEvent;
	import com.icon.tasksoftware.events.EventHub;
	import com.icon.tasksoftware.events.WebServiceRequestEvent;
	import com.icon.tasksoftware.events.WebServiceResponseEvent;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import feathers.layout.VerticalLayout;
	
	import starling.events.Event;
	
	public class OrganizationIndex extends ApplicationScreen
	{	
		private var organization_data:Vector.<Organization>;
		private var selectedOrganization:Organization;
		
		private var header:DropDownHeader;
		private var newButton:Button;
		private var list:List;
		
		private var buttonEdit:Boolean = false;
		private var buttonDelete:Boolean = false;
		
		public function OrganizationIndex()
		{
			super();
			screen_name = Main.ORGANIZATION_INDEX;
			
			addEventListener(Event.ADDED_TO_STAGE, reset);
		}
		
		private function reset(e:Event):void
		{
			organization_data = null;
			
			var request:WebServiceRequest = new WebServiceRequest(WebServiceEndpoints.ORGANIZATION_INDEX, screen_name);
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
			
			if(organization_data)
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
					case WebServiceEndpoints.ORGANIZATION_INDEX:
						organization_data = response.data as Vector.<Organization>;
						drawList();
						break;
					case WebServiceEndpoints.ORGANIZATION_DESTROY:
						for(var i:int = 0; i < organization_data.length; i++)
						{
							if(organization_data[i].id == Organization(response.data).id)
							{
								organization_data.splice(i, 1);
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
			
			header = new DropDownHeader(DropDownHeader.ORGANIZATIONS);
			addChild(header);
			
			newButton = new Button();
			newButton.label = "Create New Organization";
			newButton.addEventListener(Event.TRIGGERED, onNewButton)
			addChild(newButton);
			
			list = new List();
			addChild(list);
		}
		
		protected function done(e:WebServiceResponseEvent = null):void
		{
			organization_data = JSON.parse(e.data as String) as Vector.<Organization>;
			drawList();
		}
		
		private function drawList():void
		{
			buttonEdit = false;
			buttonDelete = false;
			
			list.dataProvider = new ListCollection(organization_data);
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
				selectedOrganization = Organization(list.selectedItem);
				
				if(buttonEdit)
				{
					dispatchEventWith("organizationEdit", false, selectedOrganization);
				}
				else if(buttonDelete)
				{
					var dialogButtons:Vector.<DialogButton> = new Vector.<DialogButton>();
					dialogButtons.push(new DialogButton("OK", deleteOrganization));
					dialogButtons.push(new DialogButton("Cancel", closePopUpDialog));
					dispatchEvent(new ApplicationEvent(ApplicationEvent.DIALOG_OPEN, false, new DialogData("Delete Organization", "Are you sure you want to delete '" + selectedOrganization.name + "'?", dialogButtons)));
				}
				else
				{
					dispatchEventWith("organizationShow", false, selectedOrganization);
				}
				
				buttonEdit = false;
				buttonDelete = false;
				
				list.selectedIndex = -1;
			}
		}
		
		private function deleteOrganization():void
		{
			var request:WebServiceRequest = new WebServiceRequest(WebServiceEndpoints.ORGANIZATION_DESTROY, screen_name, selectedOrganization);
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
			dispatchEventWith("organizationNew");
		}
	}
}