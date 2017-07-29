package  com.efg.games.flakcannon
{
	// Import necessary classes from the flash libraries
	
	import flash.display.Sprite	
	import flash.display.Bitmap; 
	import flash.display.BitmapData;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Steve Fulton
	 */
	public class Shot extends Sprite
	{
		public var imageBitmapData:BitmapData;
		public var image:Bitmap;
		private var startLocation:Point;
		private var endLocation:Point;		
		private var xunits:Number;
		private var yunits:Number;
		private var nextLocation:Point;
		private var speed:Number = 15;
		private var moves:int = 0;
		public var finished:Boolean;
		
		
		//**Flex Framework Only
		[Embed(source = "assets/flakassets.swf", symbol="ShotGif")]
		private var ShotGif:Class;
		
			
		public function Shot (startX:Number, startY:Number, endX:Number, endY:Number)	{			
			startLocation = new Point(startX,startY);
			endLocation = new Point(endX,endY);
			nextLocation = new Point(0,0);
		 	init();
		}
		
		
		public function init():void {									
			x = startLocation.x;
			y = startLocation.y;
			
			var xd:Number  = endLocation.x - x;
			var yd:Number  = endLocation.y - y;
			var distance:Number  = Math.sqrt(xd*xd + yd*yd);
			moves = Math.floor(Math.abs(distance/speed));
		
			xunits = (endLocation.x - x)/moves;
			yunits = (endLocation.y - y)/moves;
		
			
			//***** Flex *****
			imageBitmapData = new ShotGif().bitmapData;
			
			//***** Flash *****
			//imageBitmapData = new ShotGif(0,0);
			
			image = new Bitmap(imageBitmapData);			
			addChild(image);
			
			finished = false;
		}
		
		public function update():void {
			if (moves > 0) {
				nextLocation.x = x + xunits;
				nextLocation.y = y + yunits;
				moves--;
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