package com.icon.tasksoftware.data.models
{
	import com.icon.tasksoftware.data.models.base.TaskSoftwareModel;

	public class Organization extends TaskSoftwareModel
	{
		public var employees:Vector.<User>;
		public var teams:Vector.<Team>;
		
		public function Organization()
		{
			employees = new Vector.<User>();
			teams = new Vector.<Team>();
		}
	}
}