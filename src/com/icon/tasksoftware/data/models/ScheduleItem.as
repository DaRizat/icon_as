package com.icon.tasksoftware.data.models
{
	import com.icon.tasksoftware.data.models.base.TaskSoftwareModel;

	public class ScheduleItem extends TaskSoftwareModel
	{
		public var completed:Boolean;
		public var task_id:String;
		
		public function ScheduleItem()
		{
		}
	}
}