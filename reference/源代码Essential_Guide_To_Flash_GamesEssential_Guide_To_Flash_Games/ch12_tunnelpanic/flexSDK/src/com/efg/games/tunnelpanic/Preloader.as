package com.efg.games.tunnelpanic
{
	//Must set compiler option of "-frame start Main" in Additional compiler options
	//for this to work. 
	//not needed with Mochi pre-loader ad
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	

	/**
	 * ...
	 * @author Jeff Fulton
	 */
	public class Preloader extends MovieClip 
	{
		private var appBackBD:BitmapData = new BitmapData(600, 400, false, 0x000000);
		private var appBackBitmap:Bitmap = new Bitmap(appBackBD);
		private var textfield:TextField = new TextField();
		private var headerTextfield:TextField = new TextField();
		private var textFormat:TextFormat = new TextFormat("_sans", "11", "0xffffff", "true");  
		private var loadingString:String;
		
		public function Preloader() 
		{
			trace("pre loader");
			textfield.defaultTextFormat = textFormat;
			headerTextfield.defaultTextFormat = textFormat;
			headerTextfield.text = "loader on screen";
			textfield.x = 280;
			textfield.y = 200;
			addChild(appBackBitmap);
			addChild(textfield);
			addChild(headerTextfield);
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			// show loader
		}
		
		private function progress(e:ProgressEvent):void 
		{
			// update loader
			trace("loader");
			trace(e.bytesLoaded + "/" + e.bytesTotal);
			//textfield.text=String((e.bytesLoaded/e.bytesTotal)*100) +"% Loaded."
			var loadingInt:int = (e.bytesLoaded / e.bytesTotal) * 100;
			loadingString = "Loading: " + loadingInt + "%";
			textfield.text = loadingString;
		}
		
		private function checkFrame(e:Event):void 
		{
			if (currentFrame == totalFrames) 
			{
				removeEventListener(Event.ENTER_FRAME, checkFrame);
				startup();
			}
		}
		
		private function startup():void 
		{
			// hide loader
			removeChild(appBackBitmap);
			removeChild(textfield);
			stop();
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			var mainClass:Class = getDefinitionByName("com.efg.games.tunnelpanic.Main") as Class;
			addChild(new mainClass() as DisplayObject);
		}
		
	}
	
}