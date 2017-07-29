 package com.efg.games.flakcannon 
{
	import com.efg.framework.FrameWorkStates;
	import com.efg.framework.GameFrameWork;
	import com.efg.framework.BasicScreen;
	import com.efg.framework.ScoreBoard;
	import com.efg.framework.Game;
	import com.efg.framework.SideBySideScoreElement;
	import com.efg.framework.SoundManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.text.TextFormat;
	
	public class Main extends GameFrameWork {
		
		
		//custom sccore board elements
		public static const SCORE_BOARD_SCORE:String = "score";
		public static const SCORE_BOARD_SHOTS:String = "shots";
		public static const SCORE_BOARD_SHIPS:String = "ships";
			
		//custom sounds
		public static const SOUND_BONUS:String 		     =	 "sound bonus";
		public static const SOUND_BONUS_SHIP:String 	 =   "sound bonus ship";
		public static const SOUND_SHOOT:String 		     =   "sound shoot";
		public static const SOUND_NOSHOTS:String 		 =   "sound no shots";
		public static const SOUND_EXPLODE_PLANE:String   =   "sound explode plane";
		public static const SOUND_EXPLODE_FLAK:String    =   "sound explode flak";
		public static const SOUND_EXPLODE_SHIP:String    =   "sound explode ship";
		
		
		//**Flex Framework Only
		
		[Embed(source = 'assets/flakassets.swf', symbol = 'CrosshairsGif')] //chnaged
		private var cross:Class; //chnaged
	
		[Embed(source = 'assets/flakassets.swf', symbol = "SoundExplodeFlak")] //chnaged
		private var SoundExplodeFlak:Class; //chnaged
		
		[Embed(source = 'assets/flakassets.swf', symbol="SoundExplodePlane")] //chnaged
		private var SoundExplodePlane:Class; //chnaged
		
		[Embed(source = "assets/flakassets.swf", symbol="SoundShoot")] //chnaged
		private var SoundShoot:Class; //chnaged
	
		[Embed(source = 'assets/flakassets.swf', symbol = 'SoundNoShots')] //chnaged
		private var SoundNoShots:Class; //chnaged
		
		[Embed(source = "assets/flakassets.swf", symbol="SoundBonus")] //chnaged
		private var SoundBonus:Class; //chnaged
		
		[Embed(source = "assets/flakassets.swf", symbol="SoundBonusShip")] //chnaged
		private var SoundBonusShip:Class; //chnaged
		
		[Embed(source = "assets/flakassets.swf", symbol="SoundExplodeShip")] //chnaged
		private var SoundExplodeShip:Class; //chnaged
		
				
			
		
		public function Main() {
			init();
		}
		
		// init() is used to set up all of the things that we should only need to do one time
		override public function init():void {
			game = new FlakCannon(600,400);
			setApplicationBackGround(600,400,false, 0x0042AD);				
			//add application background to the screen as the bottom layer
						
			//add score board to the screen as the seconf layer
			scoreBoard = new ScoreBoard();
			addChild(scoreBoard);
			scoreBoardTextFormat= new TextFormat("_sans", "11", "0xffffff", "true");			
			scoreBoard.createTextElement(SCORE_BOARD_SCORE, new SideBySideScoreElement(80, 5, 15, "Score",scoreBoardTextFormat, 25, "0", scoreBoardTextFormat));
			scoreBoard.createTextElement(SCORE_BOARD_SHOTS, new SideBySideScoreElement(240, 5, 10, "Shots",scoreBoardTextFormat, 40, "0", scoreBoardTextFormat));
			scoreBoard.createTextElement(SCORE_BOARD_SHIPS, new SideBySideScoreElement(400, 5, 10, "Ships",scoreBoardTextFormat, 50, "0",  scoreBoardTextFormat));
			
			//screen text initializations
			screenTextFormat = new TextFormat("_sans", "14", "0xffffff", "true");	
			screenButtonFormat = new TextFormat("_sans", "11", "0x000000", "true");		
						
			titleScreen = new BasicScreen(FrameWorkStates.STATE_SYSTEM_TITLE, 600,400, false, 0x0042AD);
			titleScreen.createDisplayText("Flak Cannon",250,new Point(255,100),screenTextFormat);
			titleScreen.createOkButton("Go!",new Point(250,250),100,20, screenButtonFormat,0xFFFFFF,0xFF0000,2);			
			
			instructionsScreen = new BasicScreen(FrameWorkStates.STATE_SYSTEM_INSTRUCTIONS, 600,400, false, 0x0042AD);
			instructionsScreen.createDisplayText("Shoot The Enemy Planes!",300,new Point(210,100),screenTextFormat);
			instructionsScreen.createOkButton("Play",new Point(250,250),100,20, screenButtonFormat,0xFFFFFF,0xFF0000,2);			
			
			gameOverScreen = new BasicScreen(FrameWorkStates.STATE_SYSTEM_GAME_OVER, 600,400, false, 0x0042AD);
			gameOverScreen.createDisplayText("Game Over",300,new Point(250,100),screenTextFormat);
			gameOverScreen.createOkButton("Play Again",new Point(225,250),150,20, screenButtonFormat,0xFFFFFF,0xFF0000,2);
			
			levelInText = "Level ";
			levelInScreen = new BasicScreen(FrameWorkStates.STATE_SYSTEM_GAME_OVER, 600,400, false, 0x0042AD);
			levelInScreen.createDisplayText(levelInText,300,new Point(275,100),screenTextFormat);
								
			//set initial game state
			switchSystemState(FrameWorkStates.STATE_SYSTEM_TITLE);			
			waitTime= 40;
		
			soundManager.addSound(SOUND_BONUS,new SoundBonus());
			soundManager.addSound(SOUND_BONUS_SHIP, new SoundBonusShip());
			soundManager.addSound(SOUND_SHOOT,new SoundShoot());
			soundManager.addSound(SOUND_NOSHOTS,new SoundNoShots());
			soundManager.addSound(SOUND_EXPLODE_PLANE,new SoundExplodePlane());
			soundManager.addSound(SOUND_EXPLODE_FLAK,new SoundExplodeFlak());
			soundManager.addSound(SOUND_EXPLODE_SHIP,new SoundExplodeShip());		
			
			
			//create timer and run it one time
			
			
			
			frameRate = 30;
			startTimer();	
		}
		
	//Our Main will be the equivelent of the document class for a .fla file
	//We extend Sprite and not MovieClip because we are not going to use a timeline
	
	
		
		
	}
	
}