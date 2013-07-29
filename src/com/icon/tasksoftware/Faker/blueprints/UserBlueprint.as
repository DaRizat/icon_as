package com.icon.tasksoftware.Faker.blueprints
{
	import com.icon.tasksoftware.Faker.Faker;
	import com.icon.tasksoftware.data.models.User;

	public class UserBlueprint
	{
		public function UserBlueprint()
		{
		}
		
		public static function generate(quantity:uint = 0):Object
		{
			var output:Object = null;
			
			if(quantity)
			{
				output = new Vector.<User>();
				for(var i:int = 0; i < quantity; i++)
				{
					Vector.<User>(output).push(blueprint());
				}
			}
			else
			{
				output = blueprint();
			}
			
			return output;
		}
		
		private static function blueprint():User
		{
			var user:User = new User();
			
			user.id = Faker.instance.GenerateID();
			user.name = Faker.instance.GenerateUserName();
			user.email = Faker.instance.GenerateUserEmail(user.name);
			user.password = "123456";
			user.password_confirmation = "123456";
			
			return user;
		}
	}
}