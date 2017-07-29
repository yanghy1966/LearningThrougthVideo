package  com.efg.games.flakcannon
{
	// Import necessary classes from the flash libraries
	import flash.display.Shape;
	import flash.display.Sprite
	import flash.events.MouseEvent;
	import flash.display.Bitmap; 
	import flash.display.BitmapData; 
	/**
	 * ...
	 * @author Steve Fulton
	 */
	public class Ship extends Sprite
	{
		public var imageBitmapData:BitmapData;
		public var image:Bitmap;
		
		
		//**Flex Framework Only
		[Embed(source = "assets/flakassets.swf", symbol="ShipGif")]
		private var ShipGif:Class;
	    
			
		public function Ship() 	{			
		 	init();
		}
		
		
		public function init():void {									
			//***** Flex *****
			imageBitmapData = new ShipGif().bitmapData;
			
			//**** Flash *****
			//imageBitmapData = new ShipGif(0, 0);
			
			image = new Bitmap(imageBitmapData);
			addChild(image);
		}
		
		//Dispose is needed to get rid oo unwanted objects and get them ready for garbage collection
		public function dispose():void {			
			removeChild(image);			
			imageBitmapData.dispose();
			image = null;
		}
		
		
	}
	
}