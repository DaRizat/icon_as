package com.icon.tasksoftware.data.models
{
	import com.icon.tasksoftware.data.models.base.TaskSoftwareModel;

	public class Team extends TaskSoftwareModel
	{
		public var icon:String;
		public var task:Vector.<ScheduleItem>;
		
		public function Team()
		{
			task = new Vector.<ScheduleItem>();
		}
	}
}