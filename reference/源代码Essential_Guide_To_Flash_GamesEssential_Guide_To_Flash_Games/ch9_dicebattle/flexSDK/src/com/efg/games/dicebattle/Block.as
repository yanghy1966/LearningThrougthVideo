package com.efg.games.dicebattle 
{

import flash.filters.GlowFilter;
import flash.events.MouseEvent;
import flash.display.Bitmap; 
import flash.display.BitmapData; 

import com.efg.framework.TileSheet;
import com.efg.framework.BlitSprite;

public class Block extends BlitSprite {		//chnaged
		
	var blockColor:Number;
			
		//Action vars
	
	public var isFalling:Boolean;
	public var isFading:Boolean;
	public var fadeValue:Number = .05; //chnaged
	public var	fallEndY:Number;	//chnaged
	public var speed:int = 10; //chnaged
	public var nextY:int = 0;	 //chnaged
	
	//Board Info
	
	public var row:Number; //chnaged
	public var col:Number;	//chnaged
	
		
	public static const BLOCK_COLOR_RED:int		= 0; //chnaged
	public static const BLOCK_COLOR_GREEN:int 	= 1; //chnaged
	public static const BLOCK_COLOR_BLUE:int 		= 2; //chnaged
	public static const BLOCK_COLOR_VIOLET:int 	= 3; //chnaged
	public static const BLOCK_COLOR_ORANGE:int 	= 4; //chnaged
	public static const BLOCK_COLOR_YELLOW:int 	= 5; //chnaged
	public static const BLOCK_COLOR_PURPLE:int 	= 6;	//chnaged
	
		
	
	public function Block(color:Number,tileSheet:TileSheet,row:Number,col:Number,endY:Number,speed:Number) {		
		blockColor = color;
		this.row = row;
		this.col = col;
		isFalling = false;		
		isFading = false;
		var tile:Number = blockColor;
		super(tileSheet, [tile], 0);		
		this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownListener, false, 0, true);	
		this.buttonMode = true;
		this.useHandCursor = true;
		startFalling(endY,speed);
		
	}
	
	public function startFalling(endY:Number,speed:Number):void { //chnaged
		this.speed = speed;
		fallEndY = endY;
		isFalling = true;	
	}
	
	public function startFade(fadeValue:Number):void { //chnaged
		this.fadeValue = fadeValue;
		isFading=true;	
	}
	
	public function update():void { //chnaged
		
		if (isFalling) {
			nextY = y + speed;
		}
		
	
	}
	
	public function render():void { //chnaged
		
		if (isFalling) {
			y = nextY;
			if (y >= fallEndY) {
				y = fallEndY;
				isFalling = false;
			}
		}
		
		if (isFading) {			
			alpha -= fadeValue;
			if (alpha <= 0) {
				alpha = 0;
				isFading = false;
			}
		}		
	
	}
	
	public function onMouseDownListener(e:MouseEvent):void { //chnaged
		dispatchEvent(new CustomEventClickBlock(CustomEventClickBlock.EVENT_CLICK_BLOCK, this));		
			
	}	
		
	public function makeBlockClicked():void {	//chnaged			
		this.filters=[new GlowFilter(0xFFFFFF,70,4,4,3,3,false,false)]		
	}
		
	
	
	
	}
	
}