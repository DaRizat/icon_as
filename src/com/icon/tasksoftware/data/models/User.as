package com.icon.tasksoftware.data.models
{
	import com.icon.tasksoftware.data.models.base.TaskSoftwareModel;

	public class User extends TaskSoftwareModel
	{
		public var email:String;
		public var password:String;
		public var password_confirmation:String;
		public var remember_me:Boolean;
		public var tasks:Vector.<Task>;
		
		public function User()
		{
		}
	}
}