package com.icon.tasksoftware.data.models
{
	import com.icon.tasksoftware.data.models.base.TaskSoftwareModel;

	public class Role extends TaskSoftwareModel
	{
		public var users:Vector.<User>;
		
		public function Role()
		{
			users = new Vector.<User>;
		}
	}
}