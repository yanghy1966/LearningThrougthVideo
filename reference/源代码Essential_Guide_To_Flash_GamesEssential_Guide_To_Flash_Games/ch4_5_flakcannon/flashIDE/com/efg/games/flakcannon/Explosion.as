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
	public class Explosion extends Sprite
	{
		//public var imagebd:BitmapData;
		public var images:Array;
		public var image:Bitmap;
		public var currentImageIndex:int = -1;
		public var finished:Boolean;
		private var frameCounter:int = 0;
		private var frameDelay:int = 1;
		
		
		//Flex Framework Only
		/*
		[Embed(source = "assets/flakassets.swf", symbol="Ex21Gif")]
		private var Ex21Gif:Class;
		
		[Embed(source = "assets/flakassets.swf", symbol="Ex22Gif")]
		private var Ex22Gif:Class;
		
		[Embed(source = "assets/flakassets.swf", symbol="Ex23Gif")]
		private var Ex23Gif:Class;
		
		[Embed(source = "assets/flakassets.swf", symbol="Ex24Gif")]
		private var Ex24Gif:Class;
		
		[Embed(source = "assets/flakassets.swf", symbol="Ex25Gif")]
		private var Ex25Gif:Class;
		*/
				
			
		public function Explosion() 	{			
		 	init();
		}
		
		
		public function init():void {									
			image = new Bitmap();
			this.addChild(image);
			//***** Flex *****
			/*
			images = [new Ex21Gif().bitmapData,
					  new Ex22Gif().bitmapData,
					  new Ex23Gif().bitmapData,
					  new Ex24Gif().bitmapData,
					  new Ex25Gif().bitmapData					  
					  ];
			*/
			
			//***** Flash *****
					images = [new Ex21Gif(0,0),
					  new Ex22Gif(0,0),
					  new Ex23Gif(0,0),
					  new Ex24Gif(0,0),
					  new Ex25Gif(0,0)					  
					  ];
			
			setNextImage();
			frameCounter=0;
			finished=false;
			
			
		}
		
		public function setNextImage():void{
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