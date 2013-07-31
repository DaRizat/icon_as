package
{
	import com.icon.tasksoftware.controls.ApplicationScreen;
	import com.icon.tasksoftware.controls.DropDownHeader;
	import com.icon.tasksoftware.controls.ScreenNavigatorWithHistory;
	import com.icon.tasksoftware.data.WebServiceManager;
	import com.icon.tasksoftware.data.models.Organization;
	import com.icon.tasksoftware.events.ApplicationEvent;
	import com.icon.tasksoftware.events.EventHub;
	import com.icon.tasksoftware.screens.Login;
	import com.icon.tasksoftware.screens.organizations.OrganizationEdit;
	import com.icon.tasksoftware.screens.organizations.OrganizationIndex;
	import com.icon.tasksoftware.screens.organizations.OrganizationNew;
	import com.icon.tasksoftware.screens.organizations.OrganizationShow;
	
	import feathers.controls.ScreenNavigatorItem;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	import feathers.themes.IconMobileTheme;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Main extends Sprite
	{
		private static const LOGIN:String = "LOGIN";
		
		public static const ORGANIZATION_EDIT:String = "ORGANIZATION_EDIT";
		public static const ORGANIZATION_INDEX:String = "ORGANIZATION_INDEX";
		public static const ORGANIZATION_NEW:String = "ORGANIZATION_NEW";
		public static const ORGANIZATION_SHOW:String = "ORGANIZATION_SHOW";
		
		private var nav:ScreenNavigatorWithHistory;
		
		public static var user_data:Object;
		public static var selectedOrganization:Organization;
		
		private var login:ScreenNavigatorItem;
		
		private var organization_edit:ScreenNavigatorItem;
		private var organization_index:ScreenNavigatorItem;
		private var organization_new:ScreenNavigatorItem;
		private var organization_show:ScreenNavigatorItem;
		
		private var organization_edit_screen:OrganizationEdit;
		private var organization_index_screen:OrganizationIndex;
		private var organization_new_screen:OrganizationNew;
		private var organization_show_screen:OrganizationShow;
		
		public static var theme:IconMobileTheme;
		
		public function Main()
		{
			EventHub.instance.init();
			WebServiceManager.instance.init(this);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
			
			EventHub.instance.addEventListener(ApplicationEvent.CHANGE_MODEL, onChangeModel);
		}
		
		private function init(e:Event):void
		{
			theme = new IconMobileTheme(stage);
			
			nav = new ScreenNavigatorWithHistory(this);
			addChild(nav);
			
			login = new ScreenNavigatorItem(Login, {complete:onLogin}, null);
			nav.addScreen(LOGIN, login);
			
			organization_edit_screen = new OrganizationEdit();
			organization_edit = new ScreenNavigatorItem(organization_edit_screen, {back:onBack}, null);
			nav.addScreen(ORGANIZATION_EDIT, organization_edit);
			
			organization_index_screen = new OrganizationIndex();
			organization_index = new ScreenNavigatorItem(organization_index_screen, {back:onBack, organizationShow:onOrganizationShow, organizationNew:onOrganizationNew, organizationEdit:onOrganizationEdit}, null);
			nav.addScreen(ORGANIZATION_INDEX, organization_index);
			
			organization_new_screen = new OrganizationNew();
			organization_new = new ScreenNavigatorItem(organization_new_screen, {back:onBack}, null);
			nav.addScreen(ORGANIZATION_NEW, organization_new);
			
			organization_show_screen = new OrganizationShow();
			organization_show = new ScreenNavigatorItem(organization_show_screen, {back:onBack, organizationEdit:onOrganizationEdit}, null);
			nav.addScreen(ORGANIZATION_SHOW, organization_show);
			
			nav.showScreen(LOGIN);
			
			var transition:ScreenSlidingStackTransitionManager = new ScreenSlidingStackTransitionManager(nav);
		}
		
		private function onChangeModel(e:ApplicationEvent):void
		{
			var model_name:String = e.data as String;
			switch(model_name)
			{
				case DropDownHeader.ORGANIZATIONS:
					nav.clearHistory();
					nav.showScreen(ORGANIZATION_INDEX);
					break;
				case DropDownHeader.ROLES:
					//nav.clearHistory();
					//nav.showScreen(ROLE_INDEX);
					break;
				case DropDownHeader.TASKS:
					//nav.clearHistory();
					//nav.showScreen(TASK_INDEX);
					break;
				case DropDownHeader.TEAMS:
					//nav.clearHistory();
					//nav.showScreen(TEAM_INDEX);
					break;
				case DropDownHeader.USERS:
					//nav.clearHistory();
					//nav.showScreen(USER_INDEX);
					break;
			}
		}
		
		public function GetScreen(screen:String):ApplicationScreen
		{
			var output:ApplicationScreen;
			
			switch(screen)
			{
				case ORGANIZATION_EDIT:
					output = organization_edit_screen;
					break;
				case ORGANIZATION_INDEX:
					output = organization_index_screen;
					break;
				case ORGANIZATION_NEW:
					output = organization_new_screen;
					break;
				case ORGANIZATION_SHOW:
					output = organization_show_screen;
					break;
				default:
					if(screen)
					{
						trace("Main.GetScreen() ERROR - screen name is null or undefined");
					}
					else
					{
						trace("Main.GetScreen() ERROR - no ApplicationScreen matches screen name " + screen);
					}
					break;
			}
			
			return output;
		}
		
		public function ShowScreen(screen:String, item:Object):void
		{
			switch(screen)
			{
				case ORGANIZATION_EDIT:
					loadOrganizationEdit(item, true);
					break;
				case ORGANIZATION_NEW:
					loadOrganizationNew(item, true);
					break;
				case ORGANIZATION_SHOW:
					loadOrganizationShow(item, true);
					break;
				default:
					nav.showScreenWithoutHistory(screen);
			}
		}
		
		private function onOrganizationShow(e:Event, item:Object):void
		{
			loadOrganizationShow(item);
		}
		
		private function loadOrganizationShow(item:Object, ignoreHistory:Boolean = false):void
		{
			selectedOrganization = Organization(item);
			if(ignoreHistory)
			{
				nav.showScreenWithoutHistory(ORGANIZATION_SHOW);
			}
			else
			{
				nav.showScreen(ORGANIZATION_SHOW);
			}
			OrganizationShow(nav.activeScreen).organization = selectedOrganization;
		}
		
		private function onOrganizationNew(e:Event, item:Object):void
		{
			loadOrganizationNew(item);
		}
		
		private function loadOrganizationNew(item:Object, ignoreHistory:Boolean = false):void
		{
			selectedOrganization = Organization(item);
			if(ignoreHistory)
			{
				nav.showScreenWithoutHistory(ORGANIZATION_NEW);
			}
			else
			{
				nav.showScreen(ORGANIZATION_NEW);
			}
		}
		
		private function onOrganizationEdit(e:Event, item:Object):void
		{
			loadOrganizationEdit(item);
		}
		
		private function loadOrganizationEdit(item:Object, ignoreHistory:Boolean = false):void
		{
			selectedOrganization = Organization(item);
			if(ignoreHistory)
			{
				nav.showScreenWithoutHistory(ORGANIZATION_EDIT);
			}
			else
			{
				nav.showScreen(ORGANIZATION_EDIT);
			}
			OrganizationEdit(nav.activeScreen).organization = selectedOrganization;
		}
		
		private function onLogin(e:Event):void
		{
			nav.showScreen(ORGANIZATION_INDEX);
		}
		
		private function onBack(e:Event, item:Object):void
		{
			nav.goBack(item);
		}
	}
}