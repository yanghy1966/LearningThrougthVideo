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
	public class Flak extends Sprite
	{
		public var images:Array;
		public var image:Bitmap;
		public var currentImageIndex:int = -1;
		public var finished:Boolean;
		private var frameCounter:int = 0;
		private var frameDelay:int = 2;
		public var hits:int;
		
		
		//**Flex Framework Only
		[Embed(source = "assets/flakassets.swf", symbol="Exp1Gif")]
		private var Exp1Gif:Class;
		
		[Embed(source = "assets/flakassets.swf", symbol="Exp2Gif")]
		private var Exp2Gif:Class;
		
		[Embed(source = "assets/flakassets.swf", symbol="Exp3Gif")]
		private var Exp3Gif:Class;
		
		[Embed(source = "assets/flakassets.swf", symbol="Exp4Gif")]
		private var Exp4Gif:Class;
		
		[Embed(source = "assets/flakassets.swf", symbol="Exp5Gif")]
		private var Exp5Gif:Class;
		
		[Embed(source = "assets/flakassets.swf", symbol="Exp6Gif")]
		private var Exp6Gif:Class;
		
		[Embed(source = "assets/flakassets.swf", symbol="Exp7Gif")]
		private var Exp7Gif:Class;
		
			
		public function Flak() 	{			
			hits=0;
		 	init();
		}
		
		
		public function init():void {									
			image = new Bitmap();
			addChild(image);
			
			//***** Flex *****
			images = [new Exp1Gif().bitmapData,
					  new Exp2Gif().bitmapData,
					  new Exp3Gif().bitmapData,
					  new Exp4Gif().bitmapData,
					  new Exp5Gif().bitmapData,
					  new Exp6Gif().bitmapData,
					  new Exp7Gif().bitmapData
					  ];
			
					  
			//***** Flash *****
			/*
			images = [new Exp1Gif(0,0),
					  new Exp2Gif(0,0),
					  new Exp3Gif(0,0),
					  new Exp4Gif(0,0),
					  new Exp5Gif(0,0),
					  new Exp6Gif(0,0),
					  new Exp7Gif(0,0)
					  ];
			*/
					  
			setNextImage();
			frameCounter=0;
			finished=false;
			
		}
		
		public function setNextImage():void {
			currentImageIndex++;
			if (currentImageIndex > images.length-1) {
				finished=true;
			} else {				
				image.bitmapData = images[currentImageIndex];
				
			}
			
		}
		
		public function update():void {
			
			frameCounter++;
		}
			
		
		public function render():void {
			if (frameCounter >= frameDelay && !finished) {
				setNextImage();
				frameCounter=0;
			}
		
		}
		
		
		//Dispose is needed to get rid oo unwanted objects and get them ready for garbage collection
		public function dispose():void {
			removeChild(image);					
			for each ( var tempImage:BitmapData in images ) { 					
				tempImage.dispose();				
			}			
			images = null;
			
		}
		
		
	}
	
}