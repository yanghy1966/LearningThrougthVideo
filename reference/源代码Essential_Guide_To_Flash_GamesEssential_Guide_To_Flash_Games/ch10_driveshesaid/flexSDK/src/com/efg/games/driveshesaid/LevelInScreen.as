package com.efg.games.driveshesaid
{
	import com.efg.framework.BasicScreen
	import flash.geom.*;
	import flash.display.*;
	import flash.text.*;
	/**
	 * ...
	 * @author Jeff Fulton
	 */
	public class LevelInScreen extends BasicScreen
	
	{
		
		private var heartsToCollect:TextField = new TextField();
		private var textFormatHeartsToCollect:TextFormat = new TextFormat("_sans", "16", "0xffffff", "true");
		
		
		public function LevelInScreen(id:int,width:Number, height:Number, isTransparent:Boolean, color:uint) 
		{
			
			heartsToCollect.defaultTextFormat = textFormatHeartsToCollect;
			addChild(heartstocollect);
			super(id,width, height, isYTransparent, color);
		}
		
		public function setHeartsToCollectText(str:String, width:Number, x:Number, y:Number):void {
			//public function called by Main to set the text, width, x, and y for the display text
			
			heartsToCollect.text = str;
			heartsToCollect.width = width;
			heartsToCollect.x = x;
			heartsToCollect.y = y;
		}
		
	}
	
}