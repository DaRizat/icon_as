package
{
	import com.icon.tasksoftware.controls.ApplicationScreen;
	import com.icon.tasksoftware.controls.DropDownHeader;
	import com.icon.tasksoftware.controls.ScreenNavigatorWithHistory;
	import com.icon.tasksoftware.data.WebServiceManager;
	import com.icon.tasksoftware.data.models.Organization;
	import com.icon.tasksoftware.data.models.Role;
	import com.icon.tasksoftware.data.models.Task;
	import com.icon.tasksoftware.data.models.Team;
	import com.icon.tasksoftware.data.models.User;
	import com.icon.tasksoftware.events.ApplicationEvent;
	import com.icon.tasksoftware.events.EventHub;
	import com.icon.tasksoftware.screens.Login;
	import com.icon.tasksoftware.screens.organizations.OrganizationEdit;
	import com.icon.tasksoftware.screens.organizations.OrganizationIndex;
	import com.icon.tasksoftware.screens.organizations.OrganizationNew;
	import com.icon.tasksoftware.screens.organizations.OrganizationShow;
	import com.icon.tasksoftware.screens.roles.RoleEdit;
	import com.icon.tasksoftware.screens.roles.RoleIndex;
	import com.icon.tasksoftware.screens.roles.RoleNew;
	import com.icon.tasksoftware.screens.roles.RoleShow;
	import com.icon.tasksoftware.screens.tasks.TaskEdit;
	import com.icon.tasksoftware.screens.tasks.TaskIndex;
	import com.icon.tasksoftware.screens.tasks.TaskNew;
	import com.icon.tasksoftware.screens.tasks.TaskShow;
	import com.icon.tasksoftware.screens.teams.TeamIndex;
	import com.icon.tasksoftware.screens.users.UserIndex;
	
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
		
		public static var ROLE_EDIT:String = "ROLE_EDIT";
		public static var ROLE_INDEX:String = "ROLE_INDEX";
		public static var ROLE_NEW:String = "ROLE_NEW";
		public static var ROLE_SHOW:String = "ROLE_SHOW";
		
		public static var TASK_EDIT:String = "TASK_EDIT";
		public static var TASK_INDEX:String = "TASK_INDEX";
		public static var TASK_NEW:String = "TASK_NEW";
		public static var TASK_SHOW:String = "TASK_SHOW";
		
		public static var TEAM_EDIT:String = "TEAM_EDIT";
		public static var TEAM_INDEX:String = "TEAM_INDEX";
		public static var TEAM_NEW:String = "TEAM_NEW";
		public static var TEAM_SHOW:String = "TEAM_SHOW";
		
		public static var USER_EDIT:String = "USER_EDIT";
		public static var USER_INDEX:String = "USER_INDEX";
		public static var USER_NEW:String = "USER_NEW";
		public static var USER_SHOW:String = "USER_SHOW";
		
		private var nav:ScreenNavigatorWithHistory;
		
		public static var user_data:Object;
		public static var selectedOrganization:Organization;
		public static var selectedRole:Role;
		public static var selectedTask:Task;
		public static var selectedTeam:Team;
		public static var selectedUser:User;
		
		private var login:ScreenNavigatorItem;
		
		private var organization_edit:ScreenNavigatorItem;
		private var organization_index:ScreenNavigatorItem;
		private var organization_new:ScreenNavigatorItem;
		private var organization_show:ScreenNavigatorItem;
		
		private var organization_edit_screen:OrganizationEdit;
		private var organization_index_screen:OrganizationIndex;
		private var organization_new_screen:OrganizationNew;
		private var organization_show_screen:OrganizationShow;
		
		private var role_edit:ScreenNavigatorItem;
		private var role_index:ScreenNavigatorItem;
		private var role_new:ScreenNavigatorItem;
		private var role_show:ScreenNavigatorItem;
		
		private var role_edit_screen:RoleEdit;
		private var role_index_screen:RoleIndex;
		private var role_new_screen:RoleNew;
		private var role_show_screen:RoleShow;
		
		private var task_edit:ScreenNavigatorItem;
		private var task_index:ScreenNavigatorItem;
		private var task_new:ScreenNavigatorItem;
		private var task_show:ScreenNavigatorItem;
		
		private var task_edit_screen:TaskEdit;
		private var task_index_screen:TaskIndex;
		private var task_new_screen:TaskNew;
		private var task_show_screen:TaskShow;
		
		//private var team_edit:ScreenNavigatorItem;
		private var team_index:ScreenNavigatorItem;
		//private var team_new:ScreenNavigatorItem;
		//private var team_show:ScreenNavigatorItem;
		
		//private var team_edit_screen:TeamEdit;
		private var team_index_screen:TeamIndex;
		//private var team_new_screen:TeamNew;
		//private var team_show_screen:TeamShow;
		
		//private var user_edit:ScreenNavigatorItem;
		private var user_index:ScreenNavigatorItem;
		//private var user_new:ScreenNavigatorItem;
		//private var user_show:ScreenNavigatorItem;
		
		//private var user_edit_screen:UserEdit;
		private var user_index_screen:UserIndex;
		//private var user_new_screen:UserNew;
		//private var user_show_screen:UserShow;
		
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
			
			role_edit_screen = new RoleEdit();
			role_edit = new ScreenNavigatorItem(role_edit_screen, {back:onBack}, null);
			nav.addScreen(ROLE_EDIT, role_edit);
			
			role_index_screen = new RoleIndex();
			role_index = new ScreenNavigatorItem(role_index_screen, {back:onBack, roleShow:onRoleShow, roleNew:onRoleNew, roleEdit:onRoleEdit}, null);
			nav.addScreen(ROLE_INDEX, role_index);
			
			role_new_screen = new RoleNew();
			role_new = new ScreenNavigatorItem(role_new_screen, {back:onBack}, null);
			nav.addScreen(ROLE_NEW, role_new);
			
			role_show_screen = new RoleShow();
			role_show = new ScreenNavigatorItem(role_show_screen, {back:onBack, roleEdit:onRoleEdit}, null);
			nav.addScreen(ROLE_SHOW, role_show);
			
			task_edit_screen = new TaskEdit();
			task_edit = new ScreenNavigatorItem(task_edit_screen, {back:onBack}, null);
			nav.addScreen(TASK_EDIT, task_edit);
			
			task_index_screen = new TaskIndex();
			task_index = new ScreenNavigatorItem(task_index_screen, {back:onBack, taskShow:onTaskShow, taskNew:onTaskNew, taskEdit:onTaskEdit}, null);
			nav.addScreen(TASK_INDEX, task_index);
			
			task_new_screen = new TaskNew();
			task_new = new ScreenNavigatorItem(task_new_screen, {back:onBack}, null);
			nav.addScreen(TASK_NEW, task_new);
			
			task_show_screen = new TaskShow();
			task_show = new ScreenNavigatorItem(task_show_screen, {back:onBack, taskEdit:onTaskEdit}, null);
			nav.addScreen(TASK_SHOW, task_show);
			
			//team_edit_screen = new TeamEdit();
			//team_edit = new ScreenNavigatorItem(team_edit_screen, {back:onBack}, null);
			//nav.addScreen(TEAM_EDIT, team_edit);
			
			team_index_screen = new TeamIndex();
			team_index = new ScreenNavigatorItem(team_index_screen, {back:onBack, teamShow:onTeamShow, teamNew:onTeamNew, teamEdit:onTeamEdit}, null);
			nav.addScreen(TEAM_INDEX, team_index);
			
			//team_new_screen = new TeamNew();
			//team_new = new ScreenNavigatorItem(team_new_screen, {back:onBack}, null);
			//nav.addScreen(TEAM_NEW, team_new);
			
			//team_show_screen = new TeamShow();
			//team_show = new ScreenNavigatorItem(team_show_screen, {back:onBack, teamEdit:onTeamEdit}, null);
			//nav.addScreen(TEAM_SHOW, team_show);
			
			//user_edit_screen = new UserEdit();
			//user_edit = new ScreenNavigatorItem(user_edit_screen, {back:onBack}, null);
			//nav.addScreen(USER_EDIT, user_edit);
			
			user_index_screen = new UserIndex();
			user_index = new ScreenNavigatorItem(user_index_screen, {back:onBack, userShow:onUserShow, userNew:onUserNew, userEdit:onUserEdit}, null);
			nav.addScreen(USER_INDEX, user_index);
			
			//user_new_screen = new UserNew();
			//user_new = new ScreenNavigatorItem(user_new_screen, {back:onBack}, null);
			//nav.addScreen(USER_NEW, user_new);
			
			//user_show_screen = new UserShow();
			//user_show = new ScreenNavigatorItem(user_show_screen, {back:onBack, userEdit:onUserEdit}, null);
			//nav.addScreen(USER_SHOW, user_show);
			
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
					nav.clearHistory();
					nav.showScreen(ROLE_INDEX);
					break;
				case DropDownHeader.TASKS:
					nav.clearHistory();
					nav.showScreen(TASK_INDEX);
					break;
				case DropDownHeader.TEAMS:
					nav.clearHistory();
					nav.showScreen(TEAM_INDEX);
					break;
				case DropDownHeader.USERS:
					nav.clearHistory();
					nav.showScreen(USER_INDEX);
					break;
			}
		}
		
		public function GetScreen(screen:String, active:Boolean = false):ApplicationScreen
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
				case ROLE_EDIT:
					output = role_edit_screen;
					break;
				case ROLE_INDEX:
					output = role_index_screen;
					break;
				case ROLE_NEW:
					output = role_new_screen;
					break;
				case ROLE_SHOW:
					output = role_show_screen;
					break;
				case TASK_EDIT:
					output = task_edit_screen;
					break;
				case TASK_INDEX:
					output = task_index_screen;
					break;
				case TASK_NEW:
					output = task_new_screen;
					break;
				case TASK_SHOW:
					output = task_show_screen;
					break;
				//case TEAM_EDIT:
				//	output = team_edit_screen;
				//	break;
				case TEAM_INDEX:
					output = team_index_screen;
					break;
				//case TEAM_NEW:
				//	output = team_new_screen;
				//	break;
				//case TEAM_SHOW:
				//	output = team_show_screen;
				//	break;
				//case USER_EDIT:
				//	output = user_edit_screen;
				//	break;
				case USER_INDEX:
					output = user_index_screen;
					break;
				//case USER_NEW:
				//	output = user_new_screen;
				//	break;
				//case USER_SHOW:
				//	output = user_show_screen;
				//	break;
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
			
			if(active)
			{
				output = (output == ApplicationScreen(nav.activeScreen)) ? output : null;
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
				case ROLE_EDIT:
					loadRoleEdit(item, true);
					break;
				case ROLE_NEW:
					loadRoleNew(item, true);
					break;
				case ROLE_SHOW:
					loadRoleShow(item, true);
					break;
				case TASK_EDIT:
					loadTaskEdit(item, true);
					break;
				case TASK_NEW:
					loadTaskNew(item, true);
					break;
				case TASK_SHOW:
					loadTaskShow(item, true);
					break;
				//case TEAM_EDIT:
				//	loadTeamEdit(item, true);
				//	break;
				//case TEAM_NEW:
				//	loadTeamNew(item, true);
				//	break;
				//case TEAM_SHOW:
				//	loadTeamShow(item, true);
				//	break;
				//case USER_EDIT:
				//	loadUserEdit(item, true);
				//	break;
				//case USER_NEW:
				//	loadUserNew(item, true);
				//	break;
				//case USER_SHOW:
				//	loadUserShow(item, true);
				//	break;
				default:
					nav.showScreenWithoutHistory(screen);
			}
		}
		
		//	ORGANIZATION
		private function onOrganizationShow(e:Event, item:Object):void
		{
			loadOrganizationShow(item);
		}
		
		private function loadOrganizationShow(item:Object, ignoreHistory:Boolean = false):void
		{
			selectedOrganization = Organization(item);
			organization_show_screen.organization_id = selectedOrganization.id;
			if(ignoreHistory)
			{
				nav.showScreenWithoutHistory(ORGANIZATION_SHOW);
			}
			else
			{
				nav.showScreen(ORGANIZATION_SHOW);
			}
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
			organization_edit_screen.organization_id = selectedOrganization.id;
			if(ignoreHistory)
			{
				nav.showScreenWithoutHistory(ORGANIZATION_EDIT);
			}
			else
			{
				nav.showScreen(ORGANIZATION_EDIT);
			}
		}
		
		//	ROLE
		private function onRoleShow(e:Event, item:Object):void
		{
			loadRoleShow(item);
		}
		
		private function loadRoleShow(item:Object, ignoreHistory:Boolean = false):void
		{
			selectedRole = Role(item);
			role_show_screen.role_id = selectedRole.id;
			if(ignoreHistory)
			{
				nav.showScreenWithoutHistory(ROLE_SHOW);
			}
			else
			{
				nav.showScreen(ROLE_SHOW);
			}
		}
		
		private function onRoleNew(e:Event, item:Object):void
		{
			loadRoleNew(item);
		}
		
		private function loadRoleNew(item:Object, ignoreHistory:Boolean = false):void
		{
			selectedRole = Role(item);
			if(ignoreHistory)
			{
				nav.showScreenWithoutHistory(ROLE_NEW);
			}
			else
			{
				nav.showScreen(ROLE_NEW);
			}
		}
		
		private function onRoleEdit(e:Event, item:Object):void
		{
			loadRoleEdit(item);
		}
		
		private function loadRoleEdit(item:Object, ignoreHistory:Boolean = false):void
		{
			selectedRole = Role(item);
			role_edit_screen.role_id = selectedRole.id;
			if(ignoreHistory)
			{
				nav.showScreenWithoutHistory(ROLE_EDIT);
			}
			else
			{
				nav.showScreen(ROLE_EDIT);
			}
		}
		
		//	TASK
		private function onTaskShow(e:Event, item:Object):void
		{
			loadTaskShow(item);
		}
		
		private function loadTaskShow(item:Object, ignoreHistory:Boolean = false):void
		{
			selectedTask = Task(item);
			task_show_screen.task_id = selectedTask.id;
			if(ignoreHistory)
			{
				nav.showScreenWithoutHistory(TASK_SHOW);
			}
			else
			{
				nav.showScreen(TASK_SHOW);
			}
		}
		
		private function onTaskNew(e:Event, item:Object):void
		{
			loadTaskNew(item);
		}
		
		private function loadTaskNew(item:Object, ignoreHistory:Boolean = false):void
		{
			selectedTask = Task(item);
			if(ignoreHistory)
			{
				nav.showScreenWithoutHistory(TASK_NEW);
			}
			else
			{
				nav.showScreen(TASK_NEW);
			}
		}
		
		private function onTaskEdit(e:Event, item:Object):void
		{
			loadTaskEdit(item);
		}
		
		private function loadTaskEdit(item:Object, ignoreHistory:Boolean = false):void
		{
			selectedTask = Task(item);
			task_edit_screen.task_id = selectedTask.id;
			if(ignoreHistory)
			{
				nav.showScreenWithoutHistory(TASK_EDIT);
			}
			else
			{
				nav.showScreen(TASK_EDIT);
			}
		}
		
		//	TEAM
		private function onTeamShow(e:Event, item:Object):void
		{
			loadTeamShow(item);
		}
		
		private function loadTeamShow(item:Object, ignoreHistory:Boolean = false):void
		{
		//	selectedTeam = Team(item);
		//	team_show_screen.team_id = selectedTeam.id;
		//	if(ignoreHistory)
		//	{
		//		nav.showScreenWithoutHistory(TEAM_SHOW);
		//	}
		//	else
		//	{
		//		nav.showScreen(TEAM_SHOW);
		//	}
		}
		
		private function onTeamNew(e:Event, item:Object):void
		{
			loadTeamNew(item);
		}
		
		private function loadTeamNew(item:Object, ignoreHistory:Boolean = false):void
		{
		//	selectedTeam = Team(item);
		//	if(ignoreHistory)
		//	{
		//		nav.showScreenWithoutHistory(TEAM_NEW);
		//	}
		//	else
		//	{
		//		nav.showScreen(TEAM_NEW);
		//	}
		}
		
		private function onTeamEdit(e:Event, item:Object):void
		{
			loadTeamEdit(item);
		}
		
		private function loadTeamEdit(item:Object, ignoreHistory:Boolean = false):void
		{
		//	selectedTeam = Team(item);
		//	team_edit_screen.team_id = selectedTeam.id;
		//	if(ignoreHistory)
		//	{
		//		nav.showScreenWithoutHistory(TEAM_EDIT);
		//	}
		//	else
		//	{
		//		nav.showScreen(TEAM_EDIT);
		//	}
		}
		
		//	USER
		private function onUserShow(e:Event, item:Object):void
		{
			loadUserShow(item);
		}
		
		private function loadUserShow(item:Object, ignoreHistory:Boolean = false):void
		{
		//	selectedUser = User(item);
		//	user_show_screen.user_id = selectedUser.id;
		//	if(ignoreHistory)
		//	{
		//		nav.showScreenWithoutHistory(USER_SHOW);
		//	}
		//	else
		//	{
		//		nav.showScreen(USER_SHOW);
		//	}
		}
		
		private function onUserNew(e:Event, item:Object):void
		{
			loadUserNew(item);
		}
		
		private function loadUserNew(item:Object, ignoreHistory:Boolean = false):void
		{
		//	selectedUser = User(item);
		//	if(ignoreHistory)
		//	{
		//		nav.showScreenWithoutHistory(USER_NEW);
		//	}
		//	else
		//	{
		//		nav.showScreen(USER_NEW);
		//	}
		}
		
		private function onUserEdit(e:Event, item:Object):void
		{
			loadUserEdit(item);
		}
		
		private function loadUserEdit(item:Object, ignoreHistory:Boolean = false):void
		{
		//	selectedUser = User(item);
		//	user_edit_screen.user_id = selectedUser.id;
		//	if(ignoreHistory)
		//	{
		//		nav.showScreenWithoutHistory(USER_EDIT);
		//	}
		//	else
		//	{
		//		nav.showScreen(USER_EDIT);
		//	}
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