package com.efg.games.notanks
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import com.efg.framework.TileSheet;
	// added iteration #1
	import com.efg.framework.BlitSprite; 
	import com.efg.framework.TileByTileBlitSprite; 
	// end added iteration #1
	
	//*** added in iteration2
	import flash.events.*;
	//***
	/**
	 * ...
	 * @author Jeff Fulton
	 */
	public class GameDemoIteration3 extends Sprite
	{
		
		public static const TILE_WALL:int = 0;
		public static const TILE_MOVE:int = 1
		public static const SPRITE_PLAYER:int = 2;
		public static const SPRITE_GOAL:int = 3;
		public static const SPRITE_AMMO:int = 4;
		public static const SPRITE_ENEMY:int = 5;
		public static const SPRITE_EXPLODE:int = 6;
		public static const SPRITE_MISSILE:int = 7;
		public static const SPRITE_LIVES:int = 8;
		
		//movement specific variables added in iteration #1
		public static const MOVE_UP:int = 0;
		public static const MOVE_DOWN:int = 1;
		public static const MOVE_LEFT:int = 2;
		public static const MOVE_RIGHT:int = 3;
		public static const MOVE_STOP:int = 4;
		
		//*** added iteration #1
		//player specific variables
		private var player:TileByTileBlitSprite;
		private var playerStartRow:int;
		private var playerStartCol:int;
		private var playerStarted:Boolean = false;
		private var playerInvincible:Boolean = true;
		private var playerInvincibleCountDown:Boolean = true;
		private var playerInvincibleWait:int = 100;
		private var playerInvincibleCount:int = 0;
		
		//*** end added iteration #1
		
		private var playerFrames:Array;
		private var	enemyFrames:Array;
		private var	explodeFrames:Array;
		private var	tileSheetData:Array;
		
		private var missileTiles:Array=[];
		private var explodeSmallTiles:Array;
		private var explodeLargeTiles:Array;
		private var ammoFrame:int;
		private var livesFrame:int;
		private var goalFrame:int;
		
		private var tileWidth:int = 32;
		private var tileHeight:int = 32;
		private var mapRowCount:int = 15;
		private var mapColumnCount:int = 20;
		
		private var level:int = 1;
		private var levelTileMap:Array;
		private var levelData:Level;
		private var levels:Array = [undefined,new Level1()]
		
		private var canvasBitmapData:BitmapData=new BitmapData(tileWidth * mapColumnCount, tileHeight * mapRowCount, true, 0x00000000);
		private var canvasBitmap:Bitmap = new Bitmap(canvasBitmapData);
		private var blitPoint:Point = new Point();
		private var tileBlitRectangle:Rectangle = new Rectangle(0, 0, tileWidth, tileHeight);
		
		
		//***** Flex ***** 
		private var tileSheet:TileSheet= new TileSheet(new Library.TankSheetPng().bitmapData, tileWidth, tileHeight);
		//***** End Flex *****
		
		//***** Flash IDE *****
		//private var tileSheet:TileSheet = new TileSheet(new TankSheetPng(0,0), tileWidth, tileHeight);
		//***** End Flash IDE *****
		
		//*** added in iteration #2
		private var keyPressList:Array = [];
		
		
		public function GameDemoIteration3() {
			init();
		}
		
		private function init():void {
			this.focusRect = false;
			initTileSheetData();
			player = new TileByTileBlitSprite(tileSheet, playerFrames, 0);
			readBackGroundData();
			drawLevelBackGround();
			readSpriteData();
			addChild(canvasBitmap);
			newGame();
		}
		
		private function newGame():void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownListener);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpListener);
			newLevel();
		}
		
		private function newLevel():void {
			restartPlayer();
			addChild(player);
		}
		
		private function restartPlayer(afterDeath:Boolean=false):void {
			trace("restart player");
			player.visible = true;
			player.currCol = playerStartCol;
			player.currRow = playerStartRow;
			player.x=(playerStartCol * tileWidth)+(.5*tileWidth);
			player.y = (playerStartRow * tileHeight) + (.5 * tileHeight);
			player.nextX = player.x;
			player.nextY = player.y;
			player.currentDirection = MOVE_UP;
			playerStarted = true;
			playerInvincible = true;
			playerInvincibleCountDown = true;
			playerInvincibleCount = 0;
			
			//this is as good aplace as any
			addEventListener(Event.ENTER_FRAME, runGame, false, 0, true);
			
		}
		
		private function runGame(e:Event):void {
			if (playerStarted) {
				checkInput();
			}
		}
		
		private function checkInput():void {
			//var playSound:Boolean = false;
			var lastDirection:int = player.currentDirection;
			
			if (keyPressList[38] && player.inTunnel==false) {
				if (checkTile(MOVE_UP, player )) {
					if (player.currentDirection == MOVE_UP || player.currentDirection == MOVE_DOWN || player.currentDirection == MOVE_STOP  ) {
						switchMovement(MOVE_UP, player );
						//playSound = true;
					}else if (checkCenterTile( player)) {
						switchMovement(MOVE_UP, player );
						//playSound = true;
					}
				}else {
					//trace("can't move up");
				}
				
			}
			
			if (keyPressList[40] && player.inTunnel == false) {
				
				if (checkTile(MOVE_DOWN, player )) {
					if (player.currentDirection == MOVE_DOWN || player.currentDirection == MOVE_UP || player.currentDirection == MOVE_STOP) {
						switchMovement(MOVE_DOWN, player );
						//playSound = true;
					}else if (checkCenterTile(player)) {
						switchMovement(MOVE_DOWN, player );
						//playSound = true;
					}
				
				}else {
					//trace("can't move down");
				}
				
			}
			
			if (keyPressList[39] && player.inTunnel==false) {
	
				if (checkTile(MOVE_RIGHT, player )) {
					if (player.currentDirection == MOVE_RIGHT || player.currentDirection == MOVE_LEFT || player.currentDirection == MOVE_STOP) {
						switchMovement(MOVE_RIGHT, player );
						//playSound = true;
					}else if (checkCenterTile( player)) {
						switchMovement(MOVE_RIGHT, player );
						//playSound = true;
					}
					
				}else {
				//	trace("can't move right");
				}
				
			}
			
			if (keyPressList[37] && player.inTunnel==false) {
			
				if (checkTile(MOVE_LEFT,player )) {
					if (player.currentDirection == MOVE_LEFT || player.currentDirection == MOVE_RIGHT || player.currentDirection == MOVE_STOP) {
						switchMovement(MOVE_LEFT, player );
						//playSound = true;
					}else if (checkCenterTile(player)) {
						switchMovement(MOVE_LEFT, player );
						//playSound = true;
					}
				
				}else {
					//trace("can't move left");
				}
				
			}
			
			if (keyPressList[32]&& player.inTunnel==false) {
				
				//if (ammo >0) firePlayerMissile();
				
			}
			
		//	if (lastDirection == MOVE_STOP && playSound) {
		//		dispatchEvent(new CustomEventSound(CustomEventSound.PLAY_SOUND, Main.SOUND_PLAYER_MOVE, false, 1, 0));
		//	}
			
		}
		
		private function checkTile(direction:int, object:TileByTileBlitSprite):Boolean {
			
			var row:int = object.currRow;
			var col:int = object.currCol;
	
			switch(direction) {
				case MOVE_UP:
					row--;
					if (row <0) {
						row = mapRowCount-1;
						
					}
					break;
				case MOVE_DOWN:
					
					row++;
					
					if (row == mapRowCount) {
						row = 0;
						
					}
					break;
				case MOVE_LEFT:
					col--;
					if (col <0) {
						col = mapColumnCount - 1;
						
						
					}
					break;
				case MOVE_RIGHT:
					col++;
					if (col == mapColumnCount) {
						col = 0;
						
					}
					break;
			}
			
			if (tileSheetData[levelTileMap[row][col]] == TILE_MOVE) {
				//trace("can move");
				return true;
				
			}else {
				//trace("can't move");
				return false;
			}
			
		}
		
		private function checkCenterTile( object:TileByTileBlitSprite):Boolean {
			var xCenter:int = (object.currCol * tileWidth) + (.5 * tileWidth);
			var yCenter:int= (object.currRow * tileHeight) + (.5 * tileHeight);
			
			if (object.x == xCenter && object.y == yCenter) {
				//trace("in center tile");
				return true;
				
			}else {
				//trace("not in center tile");
				return false;
				
			}
		}
		
		
		private function switchMovement(direction:int, object:TileByTileBlitSprite):void{
			switch(direction) {
				case MOVE_UP:
					//trace("move up");
					object.rotation = 0;
					object.dx = 0;
					object.dy = -1;
					object.currentDirection = MOVE_UP;
					object.animationLoop = true;
					break;
				case MOVE_DOWN:
					//trace("move down");
					object.rotation = 180;
					object.dx = 0;
					object.dy = 1;
					object.currentDirection = MOVE_DOWN;
					object.animationLoop = true;
					break;
				case MOVE_LEFT:
					//trace("move left");
					object.currentDirection = MOVE_LEFT;
					object.rotation = -90;
					object.dx = -1;
					object.dy = 0;
					object.animationLoop = true;
					break;
				case MOVE_RIGHT:
					//trace("move right");
					object.currentDirection = MOVE_RIGHT;
					object.rotation = 90;
					object.dx = 1;
					object.dy = 0;
					object.animationLoop = true;
					break;
				case MOVE_STOP:
					//trace("move stop");
					object.currentDirection = MOVE_STOP;
					object.dx = 0;
					object.dy = 0;
					object.animationLoop = false;
						
					
					break;
			}
			object.nextRow = object.currRow + object.dy;
			object.nextCol = object.currCol + object.dx;

		}
		
		private function initTileSheetData():void {
			playerFrames = [];
			enemyFrames = [];
			tileSheetData = [];
			var numberToPush:int = 99;
			var tileXML:XML = TilesheetDataXML.XMLData;
			var numTiles:int = tileXML.tile.length();
			for (var tileNum:int = 0; tileNum < numTiles; tileNum++) {
				if (String(tileXML.tile[tileNum].@type) == "walkable") {
					//tileSheetData.push(TILE_MOVE);
					numberToPush = TILE_MOVE;
				}else if (String(tileXML.tile[tileNum].@type) == "nonwalkable") {
					//tileSheetData.push(TILE_WALL);
					numberToPush = TILE_WALL;
				}else if (tileXML.tile[tileNum].@type == "sprite") {
					
					switch(String(tileXML.tile[tileNum].@name)) {
					
						case "player":
							//tileSheetData.push(SPRITE_PLAYER);
							numberToPush = SPRITE_PLAYER;
							playerFrames.push(tileNum);
							break;
						
						case "goal":
							//tileSheetData.push(SPRITE_GOAL);
							numberToPush = SPRITE_GOAL;
							goalFrame = tileNum;
							break;
							
						case "ammo":
							//tileSheetData.push( SPRITE_AMMO );
							numberToPush = SPRITE_AMMO;
							ammoFrame = tileNum;
							break;
						
						case "enemy":
							//tileSheetData.push(SPRITE_ENEMY);
							numberToPush = SPRITE_ENEMY;
							enemyFrames.push(tileNum);
							break;
						
						case "lives":
							//tileSheetData.push(SPRITE_LIVES);
							numberToPush = SPRITE_LIVES;
							livesFrame = tileNum;
							break;
						case "missile":
							//tileSheetData.push(SPRITE_LIVES);
							numberToPush = SPRITE_MISSILE;
							missileTiles.push(tileNum);
							break;
					}
					
				}
				tileSheetData.push(numberToPush);
				
				
		
			}
			explodeSmallTiles = tileXML.smallexplode.@tiles.split(",");
			explodeLargeTiles = tileXML.largeexplode.@tiles.split(",");
			
		}
		
		private function readBackGroundData():void {
			levelTileMap = [];
			levelData = levels[level];
			levelTileMap = levelData.backGroundMap;
		}
		
		private function readSpriteData():void {
		
			//place holder for reading sprite data and placing sprites on the screen
			var tileNum:int;
			var spriteMap:Array = levelData.spriteMap;
			for (var rowCtr:int = 0; rowCtr < mapRowCount; rowCtr++) {
				for (var colCtr:int = 0; colCtr < mapColumnCount; colCtr++) {
					tileNum = spriteMap[rowCtr][colCtr];
					
					switch(tileSheetData[tileNum]) {
					
						case SPRITE_PLAYER:
							player.animationLoop = false;
							playerStartRow= rowCtr;
							playerStartCol= colCtr;
							player.currRow = rowCtr;
							player.currCol = colCtr;
							player.currentDirection = MOVE_STOP;
							break;
							
						
					}
				}
			}
		}
		
		
		private function drawLevelBackGround():void {
			canvasBitmapData.lock();
			var blitTile:int;
			for (var rowCtr:int=0;rowCtr<mapRowCount;rowCtr++) {
				for (var colCtr:int = 0; colCtr < mapColumnCount; colCtr++) {
					
					blitTile = levelTileMap[rowCtr][colCtr];
					
					tileBlitRectangle.x = int(blitTile % tileSheet.tilesPerRow) * tileWidth;
					tileBlitRectangle.y = int(blitTile / tileSheet.tilesPerRow) * tileHeight;
					
					blitPoint.x=colCtr*tileHeight;
					blitPoint.y = rowCtr * tileWidth;
					
					canvasBitmapData.copyPixels(tileSheet.sourceBitmapData,tileBlitRectangle, blitPoint);
				}
			}
			canvasBitmapData.unlock();
		}
		
		private function keyDownListener(e:KeyboardEvent):void {
			trace(e.keyCode);
			keyPressList[e.keyCode]=true;
			
		}
		
		
		private function keyUpListener(e:KeyboardEvent):void {
			keyPressList[e.keyCode]=false;
		}
		
	}
	
}