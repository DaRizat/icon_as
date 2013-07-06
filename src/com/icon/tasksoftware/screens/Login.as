package com.icon.tasksoftware.screens
{
	import feathers.controls.Button;
	import feathers.controls.Check;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.controls.TextInput;
	
	import starling.events.Event;
	
	public class Login extends Screen
	{
		private var header:Header;
		private var user_label:Label;
		private var user_input:TextInput;
		private var pass_label:Label;
		private var pass_input:TextInput;
		private var remember_check:Check;
		private var remember_label:Label;
		private var submit_button:Button;
		
		public function Login()
		{
		}
		
		override protected function draw():void
		{
			header.width = actualWidth;
			
			user_input.width = actualWidth - 40;
			user_input.x = 20;
			user_input.y = header.y + header.height + 240;
			
			user_label.x = 20;
			user_label.y = user_input.y - 32;
			
			pass_input.width = actualWidth - 40;
			pass_input.x = 20;
			pass_input.y = user_input.y + 100;
			
			pass_label.x = 20;
			pass_label.y = pass_input.y - 32;
			
			remember_check.x = 24;
			remember_check.y = pass_input.y + 100;
			
			remember_label.x = remember_check.x + 32;
			remember_label.y = pass_input.y + 98;
			
			submit_button.width = actualWidth -80;
			submit_button.x = 40;
			submit_button.y = remember_check.y + 100;
		}
		
		override protected function initialize():void
		{
			header = new Header();
			header.title = "Login";
			addChild(header);
			
			user_label = new Label();
			user_label.text = "Username:";
			addChild(user_label);
			
			user_input = new TextInput();
			user_input.text = "mkearney";
			addChild(user_input);
			
			pass_label = new Label();
			pass_label.text = "Password:";
			addChild(pass_label);
			
			pass_input = new TextInput();
			pass_input.text = "password1234";
			pass_input.textEditorProperties.displayAsPassword = true;
			addChild(pass_input);
			
			remember_check = new Check();
			remember_check.isSelected = true;
			addChild(remember_check);
			
			remember_label = new Label();
			remember_label.text = "Remember username and password";
			addChild(remember_label);
			
			submit_button = new Button();
			submit_button.label = "OK";
			submit_button.addEventListener(Event.TRIGGERED, onSubmit);
			addChild(submit_button);
		}
		
		private function onSubmit(e:Event):void
		{
			dispatchEventWith("complete");
		}
	}
}