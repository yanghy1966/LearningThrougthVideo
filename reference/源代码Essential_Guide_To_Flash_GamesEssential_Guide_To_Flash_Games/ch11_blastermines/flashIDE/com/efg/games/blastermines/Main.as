package com.efg.games.blastermines
{
	
	import com.efg.framework.FrameCounter;
	import com.efg.framework.FrameRateProfiler;
	import flash.text.TextFormat;
	import flash.text.TextField; 
	import flash.text.TextFormatAlign;
	import flash.geom.Point;
	import flash.events.Event;
	
	import com.efg.framework.FrameWorkStates;
	import com.efg.framework.GameFrameWork;
	import com.efg.framework.BasicScreen;
	import com.efg.framework.ScoreBoard;
	import com.efg.framework.SideBySideScoreElement;
	import com.efg.framework.SoundManager;

	
	public class Main extends GameFrameWork {
		
		
		//custom sccore board elements
		public static const SCORE_BOARD_SCORE:String = "score";
		public static const SCORE_BOARD_LEVEL:String = "level";
		public static const SCORE_BOARD_SHIELD:String = "shield";
		public static const SCORE_BOARD_PARTICLE_POOL:String = "particlepool";
		public static const SCORE_BOARD_PARTICLE_ACTIVE:String = "particleactive";
		public static const SCORE_BOARD_PROJECTILE_POOL:String = "projectilepool";
		public static const SCORE_BOARD_PROJECTILE_ACTIVE:String = "projectileactive";
	
	
		
		//custom sounds
		public static const SOUND_MINE_EXPLODE:String="SoundMineExplode";
		public static const SOUND_MUSIC_IN_GAME:String="SoundMusicInGame";
		public static const SOUND_MUSIC_TITLE:String="SoundMusicTitle";
		public static const SOUND_PLAYER_ENTER:String = "SoundPlayerEnter";
		public static const SOUND_PLAYER_EXPLODE:String="SoundPlayerExplode";
		public static const SOUND_PLAYER_HIT:String="SoundPlayerHit";
		public static const SOUND_PLAYER_SHOOT:String = "SoundPlayerShoot";
		
		
		
		
		// Our construction only calls 
		public function Main() {
			//added in chapter 11
			if (stage) addedToStage();
			else addEventListener(Event.ADDED_TO_STAGE, addedToStage,false,0,true);
		}
		
		//function added in chapter 11
		override public function addedToStage(e:Event = null):void {
			if (e != null) {
				removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			}
			super.addedToStage();
			trace("in blastermines added to stage");
			init();
		}
		
		// init() is used to set up all of the things that we should only need to do one time
		override public function init():void {
			trace("init");
			game= new BlasterMines();
			setApplicationBackGround(600, 400, false, 0x000000);
			
			//add score board to the screen as the seconf layer
			scoreBoard = new ScoreBoard();
			addChild(scoreBoard);
			scoreBoardTextFormat = new TextFormat("_sans", "11", "0xffffff", "true");
			
			scoreBoard.createTextElement(SCORE_BOARD_SCORE, new SideBySideScoreElement(450, 100, 20, "Score", scoreBoardTextFormat, 25, "0", scoreBoardTextFormat));
			scoreBoard.createTextElement(SCORE_BOARD_LEVEL, new SideBySideScoreElement(450, 120, 20, "Level", scoreBoardTextFormat, 25, "0", scoreBoardTextFormat));
			scoreBoard.createTextElement(SCORE_BOARD_SHIELD, new SideBySideScoreElement(450, 140, 20, "Shield", scoreBoardTextFormat, 25, "0", scoreBoardTextFormat));
			scoreBoard.createTextElement(SCORE_BOARD_PARTICLE_POOL, new SideBySideScoreElement(450, 160, 20, "PartPool", scoreBoardTextFormat, 50, "0", scoreBoardTextFormat));
			scoreBoard.createTextElement(SCORE_BOARD_PARTICLE_ACTIVE, new SideBySideScoreElement(450, 170, 20, "PartActive", scoreBoardTextFormat, 50, "0", scoreBoardTextFormat));
			scoreBoard.createTextElement(SCORE_BOARD_PROJECTILE_POOL, new SideBySideScoreElement(450, 180, 20, "ProjPool", scoreBoardTextFormat, 50, "0", scoreBoardTextFormat));
			scoreBoard.createTextElement(SCORE_BOARD_PROJECTILE_ACTIVE, new SideBySideScoreElement(450, 190, 20, "ProjActive", scoreBoardTextFormat, 50, "0", scoreBoardTextFormat));
	
			
			//screen text initializations
			screenTextFormat = new TextFormat("_sans", "16", "0xffffff", "false");
			screenTextFormat.align = flash.text.TextFormatAlign.CENTER;
			screenButtonFormat = new TextFormat("_sans", "12", "0x000000", "false");
			
			
			titleScreen = new BasicScreen(FrameWorkStates.STATE_SYSTEM_TITLE,400,400,false,0x000000 );
			titleScreen.createOkButton("Play", new Point(150, 250), 100, 20, screenButtonFormat, 0x000000, 0xff0000,2);
			titleScreen.createDisplayText("Blaster Mines", 200, new Point(100, 150), screenTextFormat);
					
			instructionsScreen = new BasicScreen(FrameWorkStates.STATE_SYSTEM_INSTRUCTIONS,400,400,false,0x000000);
			instructionsScreen.createOkButton("Start", new Point(150, 250), 100, 20,screenButtonFormat, 0x000000, 0xff0000,2);
			instructionsScreen.createDisplayText("Shoot everything\nDon't get hit.",200,new Point(100,150),screenTextFormat);

			
			gameOverScreen = new BasicScreen(FrameWorkStates.STATE_SYSTEM_GAME_OVER,400,400,false,0x0000dd);
			gameOverScreen.createOkButton("Restart", new Point(150, 250), 100, 20,screenButtonFormat, 0x000000, 0xff0000,2);
			gameOverScreen.createDisplayText("Game Over",100,new Point(150,150),screenTextFormat);

			
			levelInScreen = new BasicScreen(FrameWorkStates.STATE_SYSTEM_LEVEL_IN, 400, 400, true, 0xbbff00ff);
			levelInText = "Level ";
			levelInScreen.createDisplayText(levelInText,100,new Point(150,150),screenTextFormat);
			
			pausedScreen = new BasicScreen(FrameWorkStates.STATE_SYSTEM_PAUSE,400,400,false,0xff000000 );
			pausedScreen.createOkButton("UNPAUSE", new Point(150, 250), 100, 20, screenButtonFormat, 0x000000, 0xff0000,2);
			pausedScreen.createDisplayText("Paused", 200, new Point(100, 150), screenTextFormat);
			
			
			
			//set initial game state
			switchSystemState(FrameWorkStates.STATE_SYSTEM_TITLE);
			
			
			//sounds
			//*** Flex SDK
			//soundManager.addSound(SOUND_MINE_EXPLODE,new Library.SoundMineExplode);
			//soundManager.addSound(SOUND_MUSIC_IN_GAME, new Library.SoundMusicInGame);
			//soundManager.addSound(SOUND_MUSIC_TITLE,new Library.SoundMusicTitle);
			//soundManager.addSound(SOUND_PLAYER_ENTER,new Library.SoundPlayerEnter);
			//soundManager.addSound(SOUND_PLAYER_EXPLODE,new Library.SoundPlayerExplode);
			//soundManager.addSound(SOUND_PLAYER_HIT,new Library.SoundPlayerHit);
			//soundManager.addSound(SOUND_PLAYER_SHOOT,new Library.SoundPlayerShoot);
			
			
			//flash IDE
			soundManager.addSound(SOUND_MINE_EXPLODE,new SoundMineExplode);
			soundManager.addSound(SOUND_MUSIC_IN_GAME, new SoundMusicInGame);
			soundManager.addSound(SOUND_MUSIC_TITLE,new SoundMusicTitle);
			soundManager.addSound(SOUND_PLAYER_ENTER,new SoundPlayerEnter);
			soundManager.addSound(SOUND_PLAYER_EXPLODE,new SoundPlayerExplode);
			soundManager.addSound(SOUND_PLAYER_HIT,new SoundPlayerHit);
			soundManager.addSound(SOUND_PLAYER_SHOOT,new SoundSkullHit);
			
			
			//framerate profiler
			
			frameRate = 40;
			
			frameRateProfiler = new FrameRateProfiler();
			frameRateProfiler.profilerRenderObjects = 4000;
			frameRateProfiler.profilerRenderLoops = 7;
			frameRateProfiler.profilerDisplayOnScreen= true;
			frameRateProfiler.profilerXLocation = 0;
			frameRateProfiler.profilerYLocation = 0;
			addChild(frameRateProfiler);
			frameRateProfiler.startProfile(frameRate);
			
			frameRateProfiler.addEventListener(FrameRateProfiler.EVENT_COMPLETE, frameRateProfileComplete, false, 0, true);
		}
		
		override public function frameRateProfileComplete(e:Event):void {
			//advanced timer
			trace("profiledFrameRate=" + frameRateProfiler.profilerFrameRateAverage);
			
			game.setRendering(frameRateProfiler.profilerFrameRateAverage, frameRate);
			game.timeBasedUpdateModifier = frameRate;
			
			removeEventListener(FrameRateProfiler.EVENT_COMPLETE, frameRateProfileComplete) ;
			removeChild(frameRateProfiler);
			
			//frame counter
			frameCounter.x = 400;
			frameCounter.y = 200;
			frameCounter.profiledRate = frameRateProfiler.profilerFrameRateAverage;
			frameCounter.showProfiledRate = true;
			addChild(frameCounter);
			startTimer(true);	
		}
		
		
		override public function systemGamePlay():void {
			game.runGameTimeBased(paused,timeDifference);
			
			
		}
		
		override public function systemTitle():void {
			soundManager.playSound(SOUND_MUSIC_TITLE, true,999, 20, 1);
			super.systemTitle();
		}
		
		override public function systemNewGame():void {
			trace("new game");
			soundManager.stopSound(SOUND_MUSIC_TITLE,true);
			super.systemNewGame();
		}
		
		override public function systemLevelIn():void {
			levelInScreen.alpha = 1;
			super.systemLevelIn();
		}
		
		override public function systemWait():void {
			//trace("system Level In");
			if (lastSystemState == FrameWorkStates.STATE_SYSTEM_LEVEL_IN) {
				levelInScreen.alpha -= .01;
				if (levelInScreen.alpha < 0 ) {
					dispatchEvent(new Event(EVENT_WAIT_COMPLETE));
					levelInScreen.alpha = 0;
				}
			}
		}
		
		
	}
}	
		
		
		