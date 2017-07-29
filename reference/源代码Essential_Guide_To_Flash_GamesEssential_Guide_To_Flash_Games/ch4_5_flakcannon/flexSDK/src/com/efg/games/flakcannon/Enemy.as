package  com.efg.games.flakcannon
{
	// Import necessary classes from the flash libraries
	import flash.display.Shape;
	import flash.display.Sprite
	import flash.events.MouseEvent;
	import flash.display.Bitmap; 
	import flash.display.BitmapData; 
	import flash.geom.Point;
	/**
	 * ...
	 * @author Steve Fulton
	 */
	public class Enemy extends Sprite
	{
		public var imageBitmapData:BitmapData;
		public var image:Bitmap;
		private var startLocation:Point;
		private var endLocation:Point;
		private var nextLocation:Point;
		private var speed:Number = 5;
		public var finished:Boolean;
		public var dir:Number;
		public var angle:Number;
		
		public static const DIR_DOWN:int = 1;
		public static const DIR_RIGHT:int =2;
		public static const DIR_LEFT:int  =3;
		
		
		//**Flex Framework Only
		[Embed(source = "assets/flakassets.swf", symbol="PlaneGif")]
		private var PlaneGif:Class;
		
		[Embed(source = "assets/flakassets.swf", symbol="PlaneLeftGif")]
		private var PlaneLeftGif:Class;
		
		[Embed(source = "assets/flakassets.swf", symbol="PlaneRightGif")]
		private var PlaneRightGif:Class;
		
			
		public function Enemy(startX:Number, startY:Number, endY:Number,speed:Number, dir:int) 	{			
			startLocation = new Point(startX,startY);
			endLocation = new Point(0,endY);
			nextLocation = new Point(0,0);
			this.dir = dir;
			this.speed=speed;
		 	init();
		}
		
		
		
		public function init():void {									
			x = startLocation.x;
			y = startLocation.y;
			
					
			
			switch(dir) {
				case DIR_DOWN:
					//***** Flex *****
					imageBitmapData = new PlaneGif().bitmapData;
					
					//**** Flash *****
					//imageBitmapData = new PlaneGif(0,0);
					angle = 90;
					
					break;
				case DIR_RIGHT:
					//***** Flex *****
					imageBitmapData = new PlaneRightGif().bitmapData;
					
					//**** Flash *****
					//imageBitmapData = new PlaneRightGif(0,0);
					angle = 45;
					
					break;
				case DIR_LEFT:
					//***** Flex *****
					imageBitmapData = new PlaneLeftGif().bitmapData;
					
					//**** Flash *****
					//imageBitmapData = new PlaneLeftGif(0,0);
					angle=135;
					
					break;	
			}
			image = new Bitmap(imageBitmapData);
			addChild(image);
			
			finished = false;
		}
		
		public function update():void {
			if (y < endLocation.y) {
				var radians:Number = angle * Math.PI / 180;
				nextLocation.x =  x  + Math.cos(radians) * speed;		
				nextLocation.y =  y  + Math.sin(radians) * speed;
			} else {
				finished = true;			
			}
			
		}
		
		public function render():void {
			x = nextLocation.x;
			y = nextLocation.y;
		
		}
		
		//Dispose is needed to get rid oo unwanted objects and get them ready for garbage collection
		public function dispose():void {
			removeChild(image);			
			imageBitmapData.dispose();
			image = null;
		}
		
		
	}
	
}