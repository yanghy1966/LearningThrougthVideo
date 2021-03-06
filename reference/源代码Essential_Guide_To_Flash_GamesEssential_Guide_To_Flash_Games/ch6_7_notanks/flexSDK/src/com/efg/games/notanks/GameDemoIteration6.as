﻿package com.efg.games.notanks
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
	public class GameDemoIteration6 extends Sprite
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
		
		//** added iteration #4
		private var xMin:int = 16;
		private var yMin:int = 16;
		private var xMax:int = 624;
		private var yMax:int = 464;
		private var xTunnelMin:int = -16;
		private var yTunnelMin:int = -16;
		private var xTunnelMax:int = 656;
		private var yTunnelMax:int = 496;
		//** end iteration #4
		
		//** added in iteration #5
		private var regions:Array;
		private var tempRegion:Object;
		private var enemyList:Array;
		private var tempEnemy:TileByTileBlitSprite;
		//end iteration #5
		
		//** added in iteration #6
		private var moveDirectionsToTest:Array;//private var moveDirectionList:Array = [MOVE_UP, MOVE_DOWN, MOVE_LEFT, MOVE_RIGHT, MOVE_STOP]; // used to pick andom movement
		//** end added in iteration #6
		
		//***** Flex ***** 
		private var tileSheet:TileSheet= new TileSheet(new Library.TankSheetPng().bitmapData, tileWidth, tileHeight);
		//***** End Flex *****
		
		//***** Flash IDE *****
		//private var tileSheet:TileSheet = new TileSheet(new TankSheetPng(0,0), tileWidth, tileHeight);
		//***** End Flash IDE *****
		
		//*** added in iteration #2
		private var keyPressList:Array = [];
		
		
		public function GameDemoIteration6() {
			init();
		}
		
		private function init():void {
			this.focusRect = true;
			initTileSheetData();
			newGame();
		}
		
	
			
		private function newGame():void {
			setRegions();
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownListener);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpListener);
			addChild(canvasBitmap);
			newLevel();
		}
		
		private function newLevel():void {
			enemyList = [];
			player = new TileByTileBlitSprite(tileSheet, playerFrames, 0);
			readBackGroundData();
			readSpriteData();
			drawLevelBackGround();
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
			setCurrentRegion(player);
			//this is as good aplace as any
			addEventListener(Event.ENTER_FRAME, runGame, false, 0, true);
			
		}
		
		private function runGame(e:Event):void {
			if (playerStarted) {
				checkInput();
			}
			update();
			render();
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
		
		private function update():void {
			
			//*** added iteration #4
			player.nextX = player.x + player.dx*player.moveSpeed;
			player.nextY = player.y + player.dy * player.moveSpeed;
			
			
			
			if (player.y <yMin || player.y>yMax || player.x<xMin || player.x >xMax){
				player.inTunnel = true;
			}else {
				player.inTunnel = false;
			}
			
			
			if (player.inTunnel) {
				
				
				switch(player.currentDirection) {
					case MOVE_UP:
						if (player.nextY == yTunnelMin){
							player.nextY=yTunnelMax
							
						}else if (player.nextY == yMax) {
							player.inTunnel = false;
						}
						break;
					case MOVE_DOWN:
						if (player.nextY == yTunnelMax){
							player.nextY = yTunnelMin;
							
						}else if (player.nextY == yMin) {
							player.inTunnel = false;
						}
						
						break;
					case MOVE_LEFT:
						if (player.nextX == xTunnelMin){
							player.nextX = xTunnelMax;
						}else if (player.nextX == xMax) {
							player.inTunnel = false;
						}
						
						break;
					case MOVE_RIGHT:
						if (player.nextX == xTunnelMax) {
							player.nextX = xTunnelMin;
						}else if (player.nextX == xMin) {
							player.inTunnel = false;
						}
						
						break;
					case MOVE_STOP:
						trace("stopped");
						
						break;
				}
				
			}
			
			
			player.currRow = player.nextY / tileWidth;
			player.currCol = player.nextX / tileHeight;
			
			player.updateCurrentTile();
			//*** end added iteration #4
			
			//** added iteration #6
			var enemyLength:int = enemyList.length-1;
			for (var ctr:int = enemyLength; ctr >= 0; ctr--) {
				tempEnemy = enemyList[ctr];
			
				tempEnemy.nextX = tempEnemy.x + tempEnemy.dx*tempEnemy.moveSpeed;
				tempEnemy.nextY = tempEnemy.y + tempEnemy.dy * tempEnemy.moveSpeed;
			
			
				//check to see is enemy off side of screen then set in tunnel
				if (tempEnemy.y <yMin || tempEnemy.y>yMax || tempEnemy.x<xMin || tempEnemy.x >xMax){
					tempEnemy.inTunnel = true;
				}else {
					tempEnemy.inTunnel = false;
				}
				
				if (tempEnemy.inTunnel) {
					switch(tempEnemy.currentDirection) {
						case MOVE_UP:
							if (tempEnemy.nextY == yTunnelMin){
								tempEnemy.nextY=yTunnelMax
								
							}else if (tempEnemy.nextY == yMax) {
								tempEnemy.inTunnel = false;
							}
							break;
						case MOVE_DOWN:
							if (tempEnemy.nextY == yTunnelMax){
								tempEnemy.nextY = yTunnelMin;
								
							}else if (tempEnemy.nextY == yMin) {
								tempEnemy.inTunnel = false;
							}
							
							break;
						case MOVE_LEFT:
							if (tempEnemy.nextX == xTunnelMin){
								tempEnemy.nextX = xTunnelMax;
							}else if (player.nextX == xMax) {
								tempEnemy.inTunnel = false;
							}
							
							break;
						case MOVE_RIGHT:
							if (tempEnemy.nextX == xTunnelMax) {
								tempEnemy.nextX = xTunnelMin;
							}else if (player.nextX == xMin) {
								tempEnemy.inTunnel = false;
							}
							
							break;
						case MOVE_STOP:
							//trace("stopped");
							
							break;
					}
					
					
				}
				tempEnemy.currRow = tempEnemy.nextY / tileWidth;
				tempEnemy.currCol = tempEnemy.nextX / tileHeight;
				tempEnemy.updateCurrentTile();
			}
				//** end added iteration #6
		}
		
		private function render():void {
			player.x = player.nextX;
			player.y = player.nextY;
			if (checkCenterTile(player)) {
				if (!player.inTunnel) {
					switchMovement(MOVE_STOP, player);
					setCurrentRegion(player);
					
				}
			}
			
			player.renderCurrentTile();
			
			//** added in iteration #6
			var enemyLength:int = enemyList.length-1;
			for (var ctr:int = enemyLength; ctr >= 0; ctr--) {
				tempEnemy = enemyList[ctr];
				tempEnemy.x = tempEnemy.nextX;
				tempEnemy.y = tempEnemy.nextY;
				setCurrentRegion(tempEnemy);
				if (checkCenterTile(tempEnemy)) {
					if (!tempEnemy.inTunnel) {
						switchMovement(MOVE_STOP, tempEnemy);
						chaseObject(player, tempEnemy);
					}
				}
			
			   //should enemy fire
			   checkLineOfSight(player, tempEnemy);
				
			   tempEnemy.renderCurrentTile();
			   //** end added in iteration #6
			}
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
		
		//** added in iteration #5
		private function setRegions():void {
			regions = [];
			//top left region
			var tempRegion:Object = { col1:0, row1:0, col2:9, row2:7 };
			regions.push(tempRegion);
			
			//top right region region
			tempRegion = { col1:10, row1:0, col2:19, row2:7 };
			regions.push(tempRegion);
			
			//bot left region region
			tempRegion = { col1:0, row1:8, col2:9, row2:14 };
			regions.push(tempRegion);
			
			//bot right region region
			tempRegion = { col1:10, row1:8, col2:19, row2:14 };
			regions.push(tempRegion);
		}
		//** added in iteration #5
		
		
		//** added in iteration #6
		private function chaseObject(prey:TileByTileBlitSprite, predator:TileByTileBlitSprite):void {
			//trace("chase");
			
			if (prey.currentRegion == predator.currentRegion) {
				moveDirectionsToTest = [];
				var horizontalDiff:int = predator.currCol - prey.currCol;
				var verticalDiff:int = predator.currRow - prey.currRow;
				
				if (Math.abs(verticalDiff) < Math.abs(horizontalDiff)) {
					if (verticalDiff >0) {
						//trace("AI UP");
						moveDirectionsToTest.push(MOVE_UP);
						moveDirectionsToTest.push(MOVE_DOWN);
						
					}else if (verticalDiff < 0) {
						//trace("AI DOWN");
						moveDirectionsToTest.push(MOVE_DOWN);
						moveDirectionsToTest.push(MOVE_UP);
						
					}
					
					if (horizontalDiff > 0) {
						//trace("AI LEFT");
						moveDirectionsToTest.push(MOVE_LEFT);
						moveDirectionsToTest.push(MOVE_RIGHT);
						
					}else if (horizontalDiff < 0) {
						//trace("AI RIGHT");
						moveDirectionsToTest.push(MOVE_RIGHT);
						moveDirectionsToTest.push(MOVE_LEFT);
						
					}
				
				}
				
				if (Math.abs(horizontalDiff) < Math.abs(verticalDiff)) {
					if (horizontalDiff >0) {
						//trace("AI LEFT");
						moveDirectionsToTest.push(MOVE_LEFT);
						moveDirectionsToTest.push(MOVE_RIGHT);
						
					}else if (horizontalDiff < 0) {
						//trace("AI DOWN");
						moveDirectionsToTest.push(MOVE_RIGHT);
						moveDirectionsToTest.push(MOVE_LEFT);
						
					}
					
					if (verticalDiff > 0) {
						//trace("AI UP");
						moveDirectionsToTest.push(MOVE_UP);
						moveDirectionsToTest.push(MOVE_DOWN);
						
					}else if (verticalDiff < 0) {
						//trace("AI DOWN");
						moveDirectionsToTest.push(MOVE_DOWN);
						moveDirectionsToTest.push(MOVE_UP);
						
					}
				
				}
				
				//make an educated guess
				if (Math.abs(horizontalDiff) == Math.abs(verticalDiff)) {
					
					if (int(Math.random() * 2) == 0) {
						trace("AI Random vertical");
						if (verticalDiff >0) {
						//trace("AI UP");
							moveDirectionsToTest.push(MOVE_UP);
							moveDirectionsToTest.push(MOVE_DOWN);
						}else if (verticalDiff < 0) {
						//trace("AI DOWN");
							moveDirectionsToTest.push(MOVE_DOWN);
							moveDirectionsToTest.push(MOVE_UP);
						
					    }
					}else {
						trace("AI Random horizontal");
						if (horizontalDiff >0) {
							//trace("AI LEFT");
							moveDirectionsToTest.push(MOVE_LEFT);
							moveDirectionsToTest.push(MOVE_RIGHT);
						
					    }else if (horizontalDiff < 0) {
							//trace("AI DOWN");
							moveDirectionsToTest.push(MOVE_RIGHT);
							moveDirectionsToTest.push(MOVE_LEFT);
						}
						
					}
					
				}
				
				
				
				if (horizontalDiff == 0 && verticalDiff == 0) {
					//trace("AI STOP");
					moveDirectionsToTest = [MOVE_STOP];
				}
				
				//as a final mobe for all, push in a MOVE_STOP
				moveDirectionsToTest.push(MOVE_STOP);
				
				//moveDirectionsToTest should now have a list of moves in it. 
				//loop though those, check them and set the dx and dy of the enemy.
				var moveFound:Boolean = false;
				var movePtr:int = 0;
				var move:int;
				
				while (!moveFound) {
					move = moveDirectionsToTest[movePtr];
					
					if (move==MOVE_UP && predator.inTunnel==false) {
					
						if (checkTile(MOVE_UP, predator)) {
							
							switchMovement(MOVE_UP, predator );
							moveFound = true;
						}
						
					}	
					
					if (move==MOVE_DOWN && predator.inTunnel==false) {
						//trace("player.currentDirection=" + player.currentDirection);
						if (checkTile(MOVE_DOWN, predator)) {
							
							switchMovement(MOVE_DOWN, predator );
							moveFound = true;
						}
					
					}
					
					
					if (move==MOVE_RIGHT && predator.inTunnel==false) {
						if (checkTile(MOVE_RIGHT, predator )) {
							
							switchMovement(MOVE_RIGHT, predator );
							moveFound = true;
						}
					
					}
					
					if (move==MOVE_LEFT && predator.inTunnel==false) {
						if (checkTile(MOVE_LEFT,predator )) {
							
							switchMovement(MOVE_LEFT, predator );
							moveFound = true;
						}
						
					}
					
					if (move==MOVE_STOP && predator.inTunnel==false) {
						switchMovement(MOVE_STOP, predator );
						moveFound = true;
						
					}
				
					movePtr++;
					if (movePtr == moveDirectionsToTest.length) {
						switchMovement(MOVE_STOP, predator );
						moveFound = true;
					}
				}
			}
			
		}
		//** end added in iteration #6
		
		private function checkLineOfSight(prey:TileByTileBlitSprite, predator:TileByTileBlitSprite):void {
			//rotation reference
			//up=0;
			//right=90;
			//down=180;
			//left=-90;
			
			var testDX:int;
			var testDY:int;
			var testRotation:int;
			var checkCol:int;
			var checkRow:int;
			var difference:int;
			var differenceCtr:int;
			var act:Boolean = false;
			//1. test if they are in the same col or row
			//2. if in same col (horizontalDiff), check if verticalDiff is pos or neg
			//3. if in same row (verticalDiff), check if horizontalDiff is pos or neg
			
			//**placeholder
			var enemyIntelligence:int = 50; 
			 
			
			if (prey.currentRegion == predator.currentRegion) {
				act = true;
			}else if (int(Math.random() * 100) < enemyIntelligence) {
				//trace("act based on intel");
				//if not in same region, then turn toward player
				//first be sure to turn toward the player
				var horizontalDiff:int = predator.currCol - prey.currCol;
				var verticalDiff:int = predator.currRow - prey.currRow;
				if (verticalDiff >0) {
					//trace("AI UP");
					predator.rotation = 0;
					
				}else if (verticalDiff < 0) {
					//trace("AI DOWN");
					predator.rotation = 180;
				}else if (horizontalDiff > 0) {
					//trace("AI LEFT");
					predator.rotation = -90;
					
				}else if (horizontalDiff < 0) {
					//trace("AI RIGHT");
					predator.rotation = 90;
					
				}
				act = true;
			}
				
			if (act) {
				
				if (predator.currCol == prey.currCol) {
					//trace ("same col");
					 difference = Math.abs(predator.currRow - prey.currRow);
					if (predator.currRow <prey.currRow) {
						testDX = 0;
						testDY = 1;
						testRotation = 180;
					}else if (predator.currRow > prey.currRow) {
						testDX = 0;
						testDY = -1;
						testRotation = 0;
					}else {
						testDX = 0;
						testDY = 0;
						testRotation = 99;
					}
				}else  if (predator.currRow == prey.currRow) {
					 difference = Math.abs(predator.currCol- prey.currCol);
					// trace ("same row");
					 if (predator.currCol<prey.currCol) {
						testDX = 1;
						testDY = 0;
						testRotation = 90;
					}else if (predator.currCol>prey.currCol) {
						testDX = -1;
						testDY = 0;
						testRotation = -90;
					}else {
						testDX = 0;
						testDY = 0;
						testRotation = 99;
					}
				}else {
					difference = 0;
				}
				
				
				//if (difference >0) trace("difference=" + difference);
				checkCol = predator.currCol;
				checkRow = predator.currRow;
				for (differenceCtr = 0; differenceCtr <= difference; differenceCtr++) {
					checkCol += testDX;
					checkRow += testDY;
					if (checkCol < 0 || checkCol == mapColumnCount)  {
						break;
						//trace("col hit border");
					}else if (checkRow < 0 || checkRow == mapRowCount) {
						break;
						//trace("row hit border");
					}else if (tileSheetData[levelTileMap[checkRow][checkCol]] == TILE_WALL) {
						//trace("hit wall");
						break;
					}else if (checkCol == player.currCol && checkRow == player.currRow) {
						//trace("checkRow=" + checkRow);
						//trace("checkCol=" + checkCol);
						//if predator is facing the player then fire
						if (predator.rotation == testRotation) {
							fireMissileAtPlayer(predator);
						}
						
						break;
					}else {
						//trace("hit nothing");
						//trace("checkCol=" + checkCol);
						//trace("checkRow=" + checkRow);
					}
				}
			}
		}
		
		//** end added in iteration #6
		
		private function fireMissileAtPlayer(enemySprite:TileByTileBlitSprite):void {
			trace("fire missile @ player");
		}
		//** end added in iteration #6
		
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
							
					    case SPRITE_ENEMY:
							tempEnemy = new TileByTileBlitSprite(tileSheet, enemyFrames, 0);
							tempEnemy.x=(colCtr * tileWidth)+(.5*tileWidth);
							tempEnemy.y = (rowCtr * tileHeight) + (.5 * tileHeight);
							tempEnemy.currRow = rowCtr;
							tempEnemy.currCol = colCtr;
							setCurrentRegion(tempEnemy);
							tempEnemy.currentDirection = MOVE_STOP;
							tempEnemy.animationLoop = false;
							//tempEnemy.missileDelay = enemyShotDelay;
							//tempEnemy.healthPoints = enemyHealthPoints;
							addChild(tempEnemy);
							enemyList.push(tempEnemy);
							break;	
						
					}
				}
			}
		}
		
		
		
		
			//** added in iteration #5
		private function setCurrentRegion(object:TileByTileBlitSprite):void {
			
			var regionLength:int = regions.length - 1;
			
			for (var regionCtr:int = 0; regionCtr <= regionLength; regionCtr++) {
				tempRegion = regions[regionCtr];
				
				if (object.currCol >= tempRegion.col1 && object.currCol <= tempRegion.col2 && object.currRow >= tempRegion.row1 && object.currRow <= tempRegion.row2) {
					object.currentRegion = regionCtr;
					////trace("currentRegion=" + rctr);
				}
			}
			
		}
		//** end added in iteration #5
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