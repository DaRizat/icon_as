package com.icon.tasksoftware.Faker.blueprints
{
	import com.icon.tasksoftware.Faker.Faker;
	import com.icon.tasksoftware.data.models.Team;

	public class TeamBlueprint
	{
		public function TeamBlueprint()
		{
		}
		
		public static function generate(quantity:uint = 0):Object
		{
			var output:Object = null;
			
			if(quantity)
			{
				output = new Vector.<Team>();
				for(var i:int = 0; i < quantity; i++)
				{
					Vector.<Team>(output).push(blueprint());
				}
			}
			else
			{
				output = blueprint();
			}
			
			return output;
		}
		
		private static function blueprint():Team
		{
			var team:Team = new Team();
			
			team.id = Faker.instance.GenerateID();
			team.name = Faker.instance.GenerateTeamName();
			team.icon = "";
			
			return team;
		}
	}
}