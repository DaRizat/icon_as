package com.icon.tasksoftware.Faker.blueprints
{
	import com.icon.tasksoftware.Faker.Faker;
	import com.icon.tasksoftware.data.models.Organization;

	public class OrganizationBlueprint
	{
		public function OrganizationBlueprint()
		{
		}
		
		public static function generate(quantity:uint = 0):Object
		{
			var output:Object = null;
			
			if(quantity)
			{
				output = new Vector.<Organization>();
				for(var i:int = 0; i < quantity; i++)
				{
					Vector.<Organization>(output).push(blueprint());
				}
			}
			else
			{
				output = blueprint();
			}
			
			return output;
		}
		
		private static function blueprint():Organization
		{
			var organization:Organization = new Organization();
			
			organization.id = Faker.instance.GenerateID();
			organization.name = Faker.instance.GenerateCompanyName();
			
			return organization;
		}
	}
}