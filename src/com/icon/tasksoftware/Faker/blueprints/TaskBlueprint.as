package com.icon.tasksoftware.Faker.blueprints
{
	import com.icon.tasksoftware.Faker.Faker;
	import com.icon.tasksoftware.data.models.Task;

	public class TaskBlueprint
	{
		public function TaskBlueprint()
		{
		}
		
		public static function generate(quantity:uint = 0):Object
		{
			var output:Object = null;
			
			if(quantity)
			{
				output = new Vector.<Task>();
				for(var i:int = 0; i < quantity; i++)
				{
					Vector.<Task>(output).push(blueprint());
				}
			}
			else
			{
				output = blueprint();
			}
			
			return output;
		}
		
		private static function blueprint():Task
		{
			var task:Task = new Task();
			
			task.id = Faker.instance.GenerateID();
			task.name = Faker.instance.GenerateTaskName();
			task.description = Faker.instance.lorem_sentence();
			
			return task;
		}
	}
}