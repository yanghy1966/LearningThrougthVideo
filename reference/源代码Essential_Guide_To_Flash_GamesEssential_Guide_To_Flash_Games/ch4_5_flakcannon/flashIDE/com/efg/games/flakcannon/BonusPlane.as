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
	public class BonusPlane extends Sprite
	{
		public var imageBitmapData:BitmapData;
		public var image:Bitmap;
		private var startLocation:Point;
		private var endLocation:Point;
		private var nextLocation:Point;
		private var xunits:Number;
		private var yunits:Number;
		private var speed:Number = 5;
		private var moves:int = 0;
		public var bonusValue:int = 0; 
		public var finished:Boolean;
		
				
		/*
		[Embed(source = "assets/flakassets.swf", symbol="PlaneBonusGif")]
		private var PlaneBonusGif:Class;
		*/
			
		public function BonusPlane(startX:Number, startY:Number, endX:Number, endY:Number, speed:Number, bonusValue:int) 	{		
			startLocation = new Point(startX,startY);
			endLocation = new Point(endX,endY);
			nextLocation = new Point(0,0);
			this.speed=speed;
			this.bonusValue=bonusValue;
		 	init();
			
		}
		
		
		
		public function init():void {									
			x = startLocation.x;
			y = startLocation.y;
			
			var xd:Number  = endLocation.x - x;
			var yd:Number  = endLocation.y - y;
			var Distance:Number  = Math.sqrt(xd*xd + yd*yd)
			moves = Math.floor(Math.abs(Distance/speed));
		
			xunits = (endLocation.x - x)/moves;
			yunits = (endLocation.y - y)/moves;
			
			//***** Flex *****
			//imageBitmapData = new PlaneBonusGif().bitmapData;		
			
			//***** Flash *****
			imageBitmapData = new PlaneBonusGif(0,0);
			
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
		
		//Dispose is needed to get rid of unwanted objects and get them ready for garbage collection
		public function dispose():void {
			removeChild(image);			
			imageBitmapData.dispose();
			image = null;
		}
		
		
	}
	
}