package
{
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	import feathers.themes.IconMobileTheme;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import com.icon.tasksoftware.screens.Login;
	import com.icon.tasksoftware.screens.TaskDetails;
	import com.icon.tasksoftware.screens.TaskList;
	
	public class Main extends Sprite
	{
		private static const LOGIN:String = "LOGIN";
		private static const TASK_LIST:String = "TASK_LIST";
		private static const TASK_DETAILS:String = "TASK_DETAILS";
		
		private var nav:ScreenNavigator;
		
		public static var user_data:Object;
		public static var selectedItem:Object;
		public static var selectedItemIndex:int;
		
		private var login:ScreenNavigatorItem;
		private var task_list:ScreenNavigatorItem;
		private var task_details:ScreenNavigatorItem;
		
		public static var theme:IconMobileTheme;
		
		public function Main()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			theme = new IconMobileTheme(stage);
			
			nav = new ScreenNavigator();
			addChild(nav);
			
			login = new ScreenNavigatorItem(Login, {complete:TASK_LIST}, null);
			nav.addScreen(LOGIN, login);
			
			task_list = new ScreenNavigatorItem(TaskList, {listSelected:selected}, null);
			nav.addScreen(TASK_LIST, task_list);
			
			task_details = new ScreenNavigatorItem(TaskDetails, {back:TASK_LIST, complete:onCompleteTask}, null);
			nav.addScreen(TASK_DETAILS, task_details);
			
			nav.showScreen(LOGIN);
			
			var transition:ScreenSlidingStackTransitionManager = new ScreenSlidingStackTransitionManager(nav);
		}
		
		private function selected(e:Event, item:Object):void
		{
			selectedItem = item;
			selectedItemIndex = item.index;
			nav.showScreen(TASK_DETAILS);
		}
		
		private function onCompleteTask(e:Event, item:Object):void
		{
			user_data.tasks[selectedItemIndex - 1].complete = true;
			nav.showScreen(TASK_LIST);
		}
	}
}