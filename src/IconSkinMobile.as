package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	
	[SWF(width=640, height=960, frameRate=60)]
	public class IconSkinMobile extends Sprite
	{
		public function IconSkinMobile()
		{
			var viewPortRectangle:Rectangle = new Rectangle();
			viewPortRectangle.width = 640;
			viewPortRectangle.height = 960;
			
			var starling:Starling = new Starling(Main, stage);
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			stage.addEventListener(Event.RESIZE, handleResize);
			handleResize();
			
			starling.start();
		}
		
		protected function handleResize(e:Event = null):void
		{
			var viewPortRectangle:Rectangle = new Rectangle();
			viewPortRectangle.width = stage.stageWidth;
			viewPortRectangle.height = stage.stageHeight;
			Starling.current.viewPort = viewPortRectangle;
		}
	}
}