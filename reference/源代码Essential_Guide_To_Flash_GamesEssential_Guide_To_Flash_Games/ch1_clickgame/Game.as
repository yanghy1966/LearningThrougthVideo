package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;	
	
	public class Game extends  flash.display.MovieClip{
		
		public static const STATE_INIT:int = 10;
		public static const STATE_PLAY:int = 20;
		public static const STATE_GAME_OVER:int = 30;
		
		public var gameState:int = 0;
		public var clicks:int = 0;
		
		public function Game():void {
			addEventListener(Event.ENTER_FRAME, gameLoop);
			
			gameState = STATE_INIT;
		}
		
		public function gameLoop(e:Event):void {
			switch(gameState) {
				case STATE_INIT :
					initGame();
					break
				case STATE_PLAY:
					playGame();
					break
				case STATE_GAME_OVER:
					gameOver();
					break;
			}
			
		
		}		
		
		public function initGame():void {
			stage.addEventListener(MouseEvent.CLICK, onMouseClickEvent);
			clicks = 0;
			gameState = STATE_PLAY;
		}
		
		public function playGame() {
			if (clicks >=10) {
				gameState = STATE_GAME_OVER;
			}
		}
		
		public function onMouseClickEvent(e:MouseEvent) {
			clicks++;
			trace("mouse click number:" + clicks);
		}
		
		public function gameOver():void  {
			stage.removeEventListener(MouseEvent.CLICK, onMouseClickEvent);
			gameState = STATE_INIT;
			trace("game over");
		}
	
	}
}