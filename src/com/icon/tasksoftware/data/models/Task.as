package com.icon.tasksoftware.data.models
{
	import com.icon.tasksoftware.data.models.base.TaskSoftwareModel;

	public class Task extends TaskSoftwareModel
	{
		public var completed:Boolean;
		public var description:String;
		public var image:String;
		public var qr_code:String;
		
		public function Task()
		{
		}
	}
}