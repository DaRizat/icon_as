package com.icon.tasksoftware.screens
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.themes.IconMobileTheme;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import flash.text.TextFormat;
	
	public class TaskDetails extends Screen
	{
		private var header:Header;
		private var taskIcon:Image;
		private var taskLabel:Label;
		private var image:Image;
		private var description:TextFieldTextRenderer;
		private var backButton:Button;
		private var completeButton:Button;
		
		public function TaskDetails()
		{
		}
		
		override protected function draw():void
		{
			header.width = actualWidth;
			
			taskIcon.x = 20;
			taskIcon.y = header.height + 20;
			
			taskLabel.x = taskIcon.x + taskIcon.width + 12;
			taskLabel.y = taskIcon.y + 12;
			
			if(image)
			{
				positionImage();
			}
			
			description.width = actualWidth - 40;
			description.height = actualHeight / 2.0;
			description.x = 20;
			description.y = 180 + actualHeight / 4.0 + 20;
			
			completeButton.width = actualWidth - 80;
			completeButton.x = 40;
			completeButton.y = actualHeight - completeButton.height - 20;
		}
		
		override protected function initialize():void
		{
			header = new Header();
			header.title = "Task " + Main.selectedItemID;
			addChild(header);
			
			taskIcon = new Image(Main.theme.getIcon(Main.selectedItem));
			addChild(taskIcon);
			
			taskLabel = new Label();
			taskLabel.text = Main.selectedItem.name;
			taskLabel.nameList.add(IconMobileTheme.PAGE_HEADER);
			addChild(taskLabel);
			
			if(Main.selectedItem.image != "")
			{
				var loader:Loader = new Loader();
				loader.load(new URLRequest (Main.selectedItem.image));
				loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, onLoadImage);
			}
			
			description = new TextFieldTextRenderer();
			description.text = Main.selectedItem.description;
			description.wordWrap = true;
			description.textFormat = Main.theme.smallUIDarkTextFormat;
			addChild(description);
			
			backButton = new Button();
			backButton.label = "Back";
			backButton.nameList.add(IconMobileTheme.BACK_BUTTON);
			backButton.addEventListener(starling.events.Event.TRIGGERED, onBack);
			header.leftItems = new <DisplayObject>[backButton];
			
			completeButton = new Button();
			completeButton.label = "Complete Task";
			completeButton.isEnabled = !Main.selectedItem.complete;
			completeButton.addEventListener(starling.events.Event.TRIGGERED, onComplete);
			addChild(completeButton);
		}
		
		private function onLoadImage(e:flash.events.Event):void
		{
			var loadedBitmap:Bitmap = e.currentTarget.loader.content as Bitmap;
			var texture:Texture = Texture.fromBitmap(loadedBitmap);
			image = new Image(texture);
			addChild(image);
			
			positionImage();
		}
		
		private function positionImage():void
		{
			var min_x:int = 20;
			var min_y:int = 180;
			var max_width:int = actualWidth - min_x * 2;
			var max_height:int = actualHeight / 4.0;
			
			var x:int = 0;
			var y:int = 0;
			
			var aspect_ratio:Number = image.width / image.height;
			
			var scale_x:Number = 1.0;
			var scale_y:Number = 1.0;
			
			if(aspect_ratio > 1.0)
			{
				x = min_x + (max_width - image.width * scale_x) / 2.0;
				y = min_y + (max_height - image.height * scale_y) / 2.0;
				
				if(image.width > max_width)
				{
					scale_x = scale_y = max_width / image.width;
					
					x = min_x + (max_width - image.width * scale_x) / 2.0;
					y = min_y + (max_height - image.height * scale_y) / 2.0;
					
					if(image.height * scale_y > max_height)
					{
						scale_x = scale_y = max_height / image.height;
						
						x = min_x + (max_width - image.width * scale_x) / 2.0;
						y = min_y + (max_height - image.height * scale_y) / 2.0;
					}
				}
				else if(image.height > max_height)
				{
					scale_x = scale_y = max_height / image.height;
					
					x = min_x + (max_width - image.width * scale_x) / 2.0;
					y = min_y + (max_height - image.height * scale_y) / 2.0;
					
					if(image.width * scale_x > max_width)
					{
						scale_x = scale_y = max_width / image.width;
						
						x = min_x + (max_width - image.width * scale_x) / 2.0;
						y = min_y + (max_height - image.height * scale_y) / 2.0;
					}
				}
			}
			else
			{
				x = min_x + (max_width - image.width * scale_x) / 2.0;
				y = min_y + (max_height - image.height * scale_y) / 2.0;
				
				if(image.height > max_height)
				{
					scale_x = scale_y = max_height / image.height;
					
					x = min_x + (max_width - image.width * scale_x) / 2.0;
					y = min_y + (max_height - image.height * scale_y) / 2.0;
					
					if(image.width * scale_x > max_width)
					{
						scale_x = scale_y = max_width / image.width;
						
						x = min_x + (max_width - image.width * scale_x) / 2.0;
						y = min_y + (max_height - image.height * scale_y) / 2.0;
					}
				}
				else if(image.width > max_width)
				{
					scale_x = scale_y = max_width / image.width;
					
					x = min_x + (max_width - image.width * scale_x) / 2.0;
					y = min_y + (max_height - image.height * scale_y) / 2.0;
					
					if(image.height * scale_y > max_height)
					{
						scale_x = scale_y = max_height / image.height;
						
						x = min_x + (max_width - image.width * scale_x) / 2.0;
						y = min_y + (max_height - image.height * scale_y) / 2.0;
					}
				}
			}
			
			image.width *= scale_x;
			image.height *= scale_y;
			image.x = x;
			image.y = y;
		}
		
		private function onBack(e:starling.events.Event):void
		{
			dispatchEventWith("back");
		}
		
		private function onComplete(e:starling.events.Event):void
		{
			Main.selectedItem.complete = true;
			dispatchEventWith("complete");
		}
	}
}