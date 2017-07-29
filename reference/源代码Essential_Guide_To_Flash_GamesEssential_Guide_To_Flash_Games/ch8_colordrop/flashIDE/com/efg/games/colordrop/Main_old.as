 package  
{
	// Import necessary classes from the flash libraries
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip; //**changed
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.geom.Point;
	import flash.events.TimerEvent;
	import flash.utils.getTimer;
	// Import custom classes
	// This is not necessary if everything is in the same folder
	// But Flash Develop will aid you by recognizing your classes is you do
	import CustomEvent;
	import ScoreBoard;
	
	
	//Our Main will be the equivelent of the document class for a .fla file
	//We extend Sprite and not MovieClip because we are not going to use a timeline
	
	public class Main extends MovieClip { //**Changed with assets and library for Flash
		
		//The constants for updating the screen.
		//Normal calls all functions
		//Excess allows the developer to omit calls to functions when the display frame rate is lagging

		public static const DISPLAY_UPDATE_NORMAL:int = 0;
		public static const DISPLAY_UPDATE_EXCESS:int = 1;	
		
		//The constants for our game framework state machine
		public static const STATE_SYSTEM_WAITFORCLOSE:int = 0;
		public static const STATE_SYSTEM_TITLE:int = 1;
		public static const STATE_SYSTEM_INSTRUCTIONS:int = 2;
		public static const STATE_SYSTEM_NEWGAME:int = 3;
		public static const STATE_SYSTEM_GAMEOVER:int = 4;
		public static const STATE_SYSTEM_NEWLEVEL:int = 5;
		public static const STATE_SYSTEM_LEVELIN:int = 6;
		public static const STATE_SYSTEM_GAMEPLAY:int = 7;
		public static const STATE_SYSTEM_LEVELOUT:int = 8;
		public static const STATE_SYSTEM_WAIT:int = 9;
		
		//The constants that represent simple custom Event strings
		public static const WAIT_COMPLETE:String = "wait complete";
		
		//The variables used to maintain and transfer to a new state.
		//systemFunction holds the function object to call on each frame interaction
		//currentSystemState holds the constant value for the current state
		//nextSystemState holds the constant value for the state to transition to when currentSystemState is complete

		private var systemFunction:Function;
		private var currentSystemState:int;
		private var nextSystemState:int;
		private var lastSystemState:int;
		
		//application background. This is a BitmapData box 400x400 that is black.
		//This is equivalent to adding a black box on a layer on the timeline for application 
		//background

		private var appBackBD:BitmapData = new BitmapData(600, 400, false, 0x000000); //**Changed*
		private var appBackBitmap:Bitmap = new Bitmap(appBackBD);
		
		
		
		
		//gameTimer is an actual Timer class instance used to create our game loop's continual processing
		//FRAME_RATE is the number od updates per second
		//SBTperiod is the computed number of milliseonds available for a single frame tick's procssing.
		//SBTbeforeTime taken before processing begins, it is used to profile how long the frame tick took to run
		//SBTafterTime is used with SBTbeforeTime for process profiling
		//SBTtimeDiff is the difference between the SBTafterTime and the SBTbeforeTime.
		//SBTsleepTime is the period  minus the SBTtimeDiff. Holds amount of time to sleep the timer before processing next 
		//	frame
		//SBToverSleepTime is a measure of how accurate our sleepTime was on the last interval.
		//SBTexcess holds all of the excess time that occurs in the render loop.

		public static const FRAME_RATE:int = 30;
		public var SBTperiod:Number = 1000 / FRAME_RATE;
		public var SBTbeforeTime:int = 0;
		public var SBTafterTime:int = 0;
		public var SBTtimeDiff:int = 0;
		public var SBTsleepTime:int = 0;
		public var SBToverSleepTime:int = 0;
		public var SBTexcess:int = 0;
		public var gameTimer:Timer;
		
		//The following use the BasicScreen class and pass in an id and true or false for adding a clickable "OK" button.
		//title screen
		private var titleScreen:BasicScreen = new BasicScreen("title", true, "PLAY", new Point(250,250), 100,20 ); //**changed
		//gameover screen
		private var gameoverScreen:BasicScreen = new BasicScreen("gameover",true,"RESTART",new Point(250,250), 100,20); //**changed
		//instructions screen
		private var instructionsScreen:BasicScreen = new BasicScreen("instructions",true, "START",new Point(250,250), 100,20); //**changed
		//levelinscreen
		private var levelinScreen:BasicScreen = new BasicScreen("levelin",false,"");
		
		//scoreboard is a custom class to hold an overlay of data for the user during game play
		private var scoreBoard:ScoreBoard = new ScoreBoard();
		
		
		//Game is our custom class to hold all logic for the game. 
		private var game:Game; //**changed 
		private var sndManager:SoundManager; //**changed
		
		//waitTime is used in conjunction with the STATE_SYSTEM_WAIT state
		// it suspends the game and allows animation or other processing to finish
		private var waitTime:int = 40;
		private var waitCount:int=0;
		
	
		// Our construction only calls init(). This way, we can re-init the entire system if necessary
		public function Main() {
			init();
		}
		
		// init() is used to set up all of the things that we should only need to do one time
		private function init():void {
			
			sndManager = new SoundManager(); //**changed
			
			game = new Game(600,400,sndManager); //**changed
			
			//add application background to the screen as the bottom layer
			addChild(appBackBitmap);
			
			//add score board to the screen as the seconf layer
			addChild(scoreBoard);
			
			//set initial game state
			switchSystemState(STATE_SYSTEM_TITLE);
			
			//create timer and run it one time
			gameTimer=new Timer(SBTperiod,1); 
			gameTimer.addEventListener(TimerEvent.TIMER, runGame);
			gameTimer.start();
			
			
		}
		
		//the runGame function is called by the timer. Its job is to keep the game running
		//at a constant frame rate. It does this by using the  profiling the time before the code is run and
		//the time after it finishes. If it is less than 1000/FRAMERATE then we sleep and give the system a rest.
		//if it is more than 1000/FRAMERATE then we have a problem, and must run the systemFunction(DISPLAY_UPDATE_EXCESS)
		//below.
		public function runGame(e:TimerEvent):void {
			//trace("run game");
			SBTbeforeTime = getTimer();
            SBToverSleepTime = (SBTbeforeTime - SBTafterTime) - SBTsleepTime;
			
			//****run the current system function in normal mode
			systemFunction(DISPLAY_UPDATE_NORMAL);
			//***********************************
			
			SBTafterTime = getTimer();
            SBTtimeDiff = SBTafterTime - SBTbeforeTime;
            SBTsleepTime = (SBTperiod - SBTtimeDiff) - SBToverSleepTime;        
            if (SBTsleepTime <= 0) {
                SBTexcess -= SBTsleepTime
                SBTsleepTime = 2;
            }        
            gameTimer.reset();
            gameTimer.delay = SBTsleepTime;
            gameTimer.start();

			
			while (SBTexcess > SBTperiod) {
				//****run the current system function in excess mode
				//when the system function receives this DISPLAY_UPDATE_EXCESS parameter, it can
				//change processing to aleviate the excess. For example, not run the screen update portions of code
				systemFunction(DISPLAY_UPDATE_EXCESS);
				//***********************************
		
				SBTexcess -= SBTperiod;
            }
			

			   e.updateAfterEvent();
		}

		//switchSystem state is called only when the state is to be changed (not every frame like in some switch/case
		//based simple state machines
		
		public function switchSystemState(stateval:int):void {
			lastSystemState = currentSystemState;
			currentSystemState = stateval;
			
			switch(stateval) {
				
				case STATE_SYSTEM_WAIT: 
					systemFunction = systemWait;
					break;
				
				case STATE_SYSTEM_WAITFORCLOSE:
					systemFunction = systemWaitforclose;
					break;
				
				case STATE_SYSTEM_TITLE:
					systemFunction = systemTitle;
					break;
			
			    case STATE_SYSTEM_INSTRUCTIONS:
					systemFunction = systemInstructions;
					break;
				
				case STATE_SYSTEM_NEWGAME:
					systemFunction = systemNewgame;
					break;	
				
				case STATE_SYSTEM_NEWLEVEL:
					systemFunction = systemNewlevel;
					break;
				
				case STATE_SYSTEM_LEVELIN:
					systemFunction = systemLevelin;
					break;
				
				case STATE_SYSTEM_GAMEPLAY:
					systemFunction = systemGameplay;
					break
				
				case STATE_SYSTEM_GAMEOVER:
					systemFunction = systemGameover;
					break;
			}
		}
		
		//function for displaying the title screen
		//associated with thr STATE_SYSTEM_TITLE state
		//it is called once and then processing is set to the 
		//STATE_SYSTEM_WAITFORCLOSE state to wait for the "OK" button to be clicked
		private function systemTitle(updateType:int):void {
			titleScreen.setDisplayText("Color Drop", 120, 245, 150); //chnaged
			addChild(titleScreen);
			titleScreen.addEventListener(CustomEvent.CUSTOMEVENT_OKCLICKED, okButtonClickListener, false, 0, true);
			switchSystemState(STATE_SYSTEM_WAITFORCLOSE);
			nextSystemState = STATE_SYSTEM_INSTRUCTIONS;
		}
		
		//function for displaying the instructions screen
		//associated with thr STATE_SYSTEM_INSTRUCTIONS state
		//it is called once and then processing is set to the 
		//STATE_SYSTEM_WAITFORCLOSE state to wait for the "OK" button to be clicked
		private function systemInstructions(updateType:int):void {
			instructionsScreen.setDisplayText("Click Colored Blocks", 250, 180, 150); //**changed
			addChild(instructionsScreen);
			instructionsScreen.addEventListener(CustomEvent.CUSTOMEVENT_OKCLICKED, okButtonClickListener, false, 0, true);
			switchSystemState(STATE_SYSTEM_WAITFORCLOSE);
			nextSystemState = STATE_SYSTEM_NEWGAME;
		}
		
		//systemNewGame is associated with the STATE_SYSTEM_NEWGAME state
		//it is called one time and then moves on to STATE_SYSTEM_NEWLEVEL state.
		//its purpose is to add all of the event listeners for communication between the game and Main, and the game
		//and the scoreboard
		//it also calls the game.newGame() method to allow the game instance to do its own new game
		//related processing
		private function systemNewgame(updateType:int):void {
			addChild(game);
			game.addEventListener(CustomEvent.CUSTOMEVENT_SBUPDATE, scoreBoardUpdateListener, false, 0, true);
			game.addEventListener(CustomEvent.CUSTOMEVENT_LVSUPDATE, levelScreenUpdateListener, false, 0, true);
			game.addEventListener(Game.GAMEOVER, gameOverListener, false, 0, true);
			game.addEventListener(Game.NEWLEVEL, newLevelListener, false, 0, true);
			game.newGame();
			switchSystemState(STATE_SYSTEM_NEWLEVEL);
		}
		
		//systemNewLevel is associated with the STATE_SYSTEM_NEWLEVEL state
		//its purpose is to call the game.newLevel method to allow the game to its own new level related processing
		//if we had xml data for the game level, we might process it inside a Model class and pass it to the game for the
		//related processing
		private function systemNewlevel(updateType:int):void {
			game.newLevel();
			switchSystemState(STATE_SYSTEM_LEVELIN);
		}
		
		//systemLevelin is a screen that is associated with the STATE_SYSTEM_LEVELIN state.
		//It displays the new level message for 40 frame ticks abd then moves on.
		//The Level # message is not controlled here. 
		//A custom event triggers the new level changes and the text is modfied via the CUSTOMEVENT_LVSUPDATE added 
		//in systemNewGame
		private function systemLevelin(updateType:int):void {
			addChild(levelinScreen);
			waitTime = 40;
			switchSystemState(STATE_SYSTEM_WAIT);
			nextSystemState = STATE_SYSTEM_GAMEPLAY;
			addEventListener(WAIT_COMPLETE, waitCompleteListener, false, 0, true);
			
		}
		
		//systemGameOver is a screen that is associated with the STATE_SYSTEM_GAMEOVER state.
		//it displays the game over screen message and waits for thr "OK" button click
		private function systemGameover(updateType:int):void {
			removeChild(game);
			gameoverScreen.setDisplayText("Game Over", 100, 250, 150);
			addChild(gameoverScreen);
			gameoverScreen.addEventListener(CustomEvent.CUSTOMEVENT_OKCLICKED, okButtonClickListener, false, 0, true);
			
			switchSystemState(STATE_SYSTEM_WAITFORCLOSE);
			nextSystemState = STATE_SYSTEM_TITLE;
		}
		
		//systemGameplay is the heart of the game timer. This function is associated with the 
		//STATE_SYSTEM_TITLE state. The game.runGame() function must deal with the 
		//DISPLAY_UPDATE_EXCESS or DISPLAY_UPDATE_NORMAL passes to it to keep smooth game play
		private function systemGameplay(updateType:int):void {
			game.runGame(updateType);
		}
		
		
		//systemWaitforclose is associated with the STATE_SYSTEM_WAITFORCLOSE state
		//it simple does nothing until the "OK" button on a screen is clicked. 
		private function systemWaitforclose(updateType:int):void {
			//do nothing
		}
		
		//systemWait is associated with the STATE_SYSTEM_WAIT state.
		//waitCount is uncremented in each frame tick and after waitTime is reached, it files off an event
		//to move to the next state or do other processing based in the previousState
		private function systemWait(updateType:int):void {
			waitCount++;
				if (waitCount > waitTime) {
					waitCount = 0;
					dispatchEvent(new Event(WAIT_COMPLETE));
				}
		}

		//okButtonClickListener listener function to determine what to do when each of the "OK" buttons on various
		//screens is clicked
		//it switches tot he nextSystemState when complete
		private function okButtonClickListener(e:CustomEvent):void {

			switch(e.attributes.id) {
				
				case "title":					
					removeChild(titleScreen);
					titleScreen.removeEventListener(CustomEvent.CUSTOMEVENT_OKCLICKED, okButtonClickListener);
					break;
			
			    case "instructions":
					removeChild(instructionsScreen);
					instructionsScreen.removeEventListener(CustomEvent.CUSTOMEVENT_OKCLICKED, okButtonClickListener);
					break;					
				
				case "gameover":
					removeChild(gameoverScreen);
					gameoverScreen.removeEventListener(CustomEvent.CUSTOMEVENT_OKCLICKED, okButtonClickListener);
					break;
			}
			switchSystemState(nextSystemState);
		}
		
		//scoreBoardUpdateListener the Game class communicates updates to the ScoreBoard class through this
		//custom event listener
		private function scoreBoardUpdateListener(e:CustomEvent):void {
			//trace(e.attributes.object + " " + e.attributes.value);
			scoreBoard.update(e.attributes.object, e.attributes.value);
		}
		
		//scoreBoardUpdateListener the Game class communicates updates to the BasicScreen LevelinScreen class through this
		//custom event listener
		private function levelScreenUpdateListener(e:CustomEvent):void {
			levelinScreen.setDisplayText("Level " + e.attributes.level, 100, 260, 150);
		}
		
		//gameOverListener listens for Game.GAMEOVER simple custom events calls and changes state accordingly
		private function gameOverListener(e:Event):void {
			switchSystemState(STATE_SYSTEM_GAMEOVER);
			game.removeEventListener(CustomEvent.CUSTOMEVENT_SBUPDATE, scoreBoardUpdateListener);
			game.removeEventListener(CustomEvent.CUSTOMEVENT_LVSUPDATE, levelScreenUpdateListener);
			game.removeEventListener(Game.GAMEOVER, gameOverListener);
			game.removeEventListener(Game.NEWLEVEL, newLevelListener);
		}
		
		//newLevelListener listens for Game.NEWLEVEL simple custom events calls and changes state accordingly
		private function newLevelListener(e:Event):void {
			switchSystemState(STATE_SYSTEM_NEWLEVEL);
		}
		
		//listens for the simple WAIT_COMPLETE event from the LevelIn (or any other screen that wants to used it).
		//the switch/case is in case more screens will need to use the waitTime
		private function waitCompleteListener(e:Event):void {
			switch(lastSystemState) {
				
				case STATE_SYSTEM_LEVELIN:
					removeChild(levelinScreen);
					break
			}
			removeEventListener(WAIT_COMPLETE, waitCompleteListener);
			switchSystemState(nextSystemState);
		}
		
	}
	
}