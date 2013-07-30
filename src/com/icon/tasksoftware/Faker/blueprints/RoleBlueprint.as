package com.icon.tasksoftware.Faker.blueprints
{
	import com.icon.tasksoftware.Faker.Faker;
	import com.icon.tasksoftware.data.models.Role;

	public class RoleBlueprint
	{
		public function RoleBlueprint()
		{
		}
		
		public static function generate(quantity:uint = 0):Object
		{
			var output:Object = null;
			
			if(quantity)
			{
				output = new Vector.<Role>();
				for(var i:int = 0; i < quantity; i++)
				{
					Vector.<Role>(output).push(blueprint());
				}
			}
			else
			{
				output = blueprint();
			}
			
			return output;
		}
		
		private static function blueprint():Role
		{
			var role:Role = new Role();
			
			role.id = Faker.instance.GenerateID();
			role.name = Faker.instance.GenerateRoleName();
			
			return role;
		}
	}
}