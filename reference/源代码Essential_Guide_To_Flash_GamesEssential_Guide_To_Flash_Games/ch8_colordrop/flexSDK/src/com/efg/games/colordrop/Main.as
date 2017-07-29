package com.efg.games.colordrop 
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
		public static const SCORE_BOARD_LEVEL:String = "level";
		public static const SCORE_BOARD_PLAYS:String = "plays";
		public static const SCORE_BOARD_THRESHOLD:String = "threshold";
		public static const SCORE_BOARD_LEVEL_SCORE:String = "levelScore";
			
		//custom sounds
		
		public static const SOUND_CLICK:String 			 =   "soundClick";
		public static const SOUND_BONUS:String 			 =   "soundBonus";
		public static const SOUND_WIN:String 			 =   "soundWin";
		public static const SOUND_LOSE:String 			 =   "soundLose";
		
		
		//**Flex Framework Only
		
		[Embed(source = "assets/colordropassets.swf", symbol="SoundClick")] //chnaged
		private var SoundClick:Class; //chnaged
		
		[Embed(source = "assets/colordropassets.swf", symbol="SoundBonus")] //chnaged
		private var SoundBonus:Class; //chnaged
		
		[Embed(source = "assets/colordropassets.swf", symbol="SoundWin")] //chnaged
		private var SoundWin:Class; //chnaged
		
		[Embed(source = "assets/colordropassets.swf", symbol="SoundLose")] //chnaged
		private var SoundLose:Class;		//chnaged
		
		
		
		
		// Our construction only calls init(). This way, we can re-init the entire system if necessary
		public function Main() {
			init();
		}
		
		// init() is used to set up all of the things that we should only need to do one time
		override public function init():void {
			game = new ColorDrop(600,400);
			setApplicationBackGround(600,400,false, 0x000000);				
			//add application background to the screen as the bottom layer
						
			//add score board to the screen as the seconf layer
			scoreBoard = new ScoreBoard();
			addChild(scoreBoard);
			scoreBoardTextFormat= new TextFormat("_sans", "11", "0xffffff", "true");			
			scoreBoard.createTextElement(SCORE_BOARD_SCORE, new SideBySideScoreElement(10, 5, 15, "Score",scoreBoardTextFormat, 50, "0", scoreBoardTextFormat));
			scoreBoard.createTextElement(SCORE_BOARD_LEVEL, new SideBySideScoreElement(125, 5, 15, "Level",scoreBoardTextFormat, 40, "0", scoreBoardTextFormat));
			scoreBoard.createTextElement(SCORE_BOARD_PLAYS, new SideBySideScoreElement(225, 5, 15, "Plays",scoreBoardTextFormat, 40, "0", scoreBoardTextFormat));
			scoreBoard.createTextElement(SCORE_BOARD_THRESHOLD, new SideBySideScoreElement(300, 5, 15, "Threshold",scoreBoardTextFormat, 80, "0", scoreBoardTextFormat));
			scoreBoard.createTextElement(SCORE_BOARD_LEVEL_SCORE, new SideBySideScoreElement(425, 5, 15, "Level Score",scoreBoardTextFormat, 80, "0", scoreBoardTextFormat));
						
			//screen text initializations
			screenTextFormat = new TextFormat("_sans", "14", "0xffffff", "true");	
			screenButtonFormat = new TextFormat("_sans", "11", "0x000000", "true");		
						
			titleScreen = new BasicScreen(FrameWorkStates.STATE_SYSTEM_TITLE, 600,400, false, 0x000000);
			titleScreen.createDisplayText("Color Drop",250,new Point(255,100),screenTextFormat);
			titleScreen.createOkButton("Go!",new Point(250,250),100,20, screenButtonFormat,0xFFFFFF,0x00FF0000,2);			
			
			instructionsScreen = new BasicScreen(FrameWorkStates.STATE_SYSTEM_INSTRUCTIONS, 600,400, false, 0x000000);
			instructionsScreen.createDisplayText("Click Colored Blocks",300,new Point(210,100),screenTextFormat);
			instructionsScreen.createOkButton("Play",new Point(250,250),100,20, screenButtonFormat,0xFFFFFF,0xFF0000,2);			
			
			gameOverScreen = new BasicScreen(FrameWorkStates.STATE_SYSTEM_GAME_OVER, 600,400, false, 0x000000);
			gameOverScreen.createDisplayText("Game Over",300,new Point(250,100),screenTextFormat);
			gameOverScreen.createOkButton("Play Again",new Point(225,250),150,20, screenButtonFormat,0xFFFFFF,0xFF0000,2);
			
			levelInText = "Level ";
			levelInScreen = new BasicScreen(FrameWorkStates.STATE_SYSTEM_GAME_OVER, 600,400, false, 0x000000);
			levelInScreen.createDisplayText(levelInText,300,new Point(275,100),screenTextFormat);
								
			//set initial game state
			switchSystemState(FrameWorkStates.STATE_SYSTEM_TITLE);			
			waitTime= 40;
		
			soundManager.addSound(SOUND_CLICK,new SoundClick());
			soundManager.addSound(SOUND_BONUS, new SoundBonus());
			soundManager.addSound(SOUND_WIN,new SoundWin());
			soundManager.addSound(SOUND_LOSE,new SoundLose());
					
			
			//create timer and run it one time
			
			
			
			frameRate = 40;
			startTimer();	
		}
		
	//Our Main will be the equivelent of the document class for a .fla file
	//We extend Sprite and not MovieClip because we are not going to use a timeline
	
	
		
		
	}
	
}