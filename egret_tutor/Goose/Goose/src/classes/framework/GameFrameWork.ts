// GameFrameWork.ts

module goose {
    export class GameFrameWork extends egret.DisplayObjectContainer {
        public static EVENT_WAIT_COMPLETE:string = "wait complete";
        public systemFunction:Function;
        public currentSystemState:number;
        public nextSystemState:number;
        public lastSystemState:number;
        public appBackBitmapData:egret.BitmapData;
        public appBackBitmap:egret.Bitmap;
        public frameRate:number;
        public timerPeriod:number;
        public gameTimer:egret.Timer;
        public titleScreen:goose.BasicScreen;
        public gameOverScreen:goose.BasicScreen;
        public instructionsScreen:goose.BasicScreen;
        public levelInScreen:goose.BasicScreen;
        public screenTextFormat:egret.TextFormat;
        public screenButtonFormat:egret.TextFormat;
        public levelInText:string;
        public scoreBoard:goose.ScoreBoard;
        public scoreBoardTextFormat:egret.TextFormat;
        //Game is our custom class to hold all logic for the game.
        public game:Game;
        // it suspends the game and allows animation or other
        //processing to finish
        public waitTime:number;
        public waitCount:number=0;
        //waitTime is used in conjunction with the
        //STATE_SYSTEM_WAIT state
        public constructor() {
            super();
        }

        public init(): void {
            //stub to override
        }

        // setup background
        public setApplicationBackGround(width: number, height: number,
                                        isTransparent: boolean = false, color: number = 0x000000): void {
            //let appBackBitmapData = new egret.BitmapData(width, height, isTransparent, color);
            //let appBackBitmap = new egret.Bitmap(appBackBitmapData);
            //this.addChild(appBackBitmap);
            var rec1:egret.Sprite  = new goose.RectWithColor(width,height,isTransparent,color);
            this.addChild(rec1);
        }

        // start Timer
        public startTimer(): void {
            this.timerPeriod = 1000 / this.frameRate;
            this.gameTimer = new egret.Timer(this.timerPeriod);
            this.gameTimer.addEventListener(egret.TimerEvent.TIMER, this.runGame);
            this.gameTimer.start();
        }

        public runGame(e: egret.TimerEvent): void {
            this.systemFunction();
            e.updateAfterEvent();
        }

        public switchSystemState(stateval: number): void {
            this.lastSystemState = this.currentSystemState;
            this.currentSystemState = stateval;
            switch (stateval) {
                case FrameWorkStates.STATE_SYSTEM_WAIT:
                    systemFunction = this.systemWait;
                    break;
                case FrameWorkStates.STATE_SYSTEM_WAIT_FOR_CLOSE:
                    systemFunction = this.systemWaitForClose;
                    break;
                case FrameWorkStates.STATE_SYSTEM_TITLE:
                    systemFunction = this.systemTitle;
                    break;
                case FrameWorkStates.STATE_SYSTEM_INSTRUCTIONS:
                    systemFunction = this.systemInstructions;
                    break;
                case FrameWorkStates.STATE_SYSTEM_NEW_GAME:
                    systemFunction = this.systemNewGame;
                    break;
                case FrameWorkStates.STATE_SYSTEM_NEW_LEVEL:
                    systemFunction = this.systemNewLevel;
                    break;
                case FrameWorkStates.STATE_SYSTEM_LEVEL_IN:
                    systemFunction = this.systemLevelIn;
                    break;
                case FrameWorkStates.STATE_SYSTEM_GAME_PLAY:
                    systemFunction = this.systemGamePlay;
                    break;
                case FrameWorkStates.STATE_SYSTEM_GAME_OVER:
                    systemFunction = this.systemGameOver;
                    break;
            }
        }// end

        public systemTitle(): void {
            this.addChild(this.titleScreen);
            this.titleScreen.addEventListener(CustomEventButtonId.BUTTON_ID, okButtonClickListener, false, 0, true);
            this.switchSystemState(FrameWorkStates.STATE_SYSTEM_WAIT_FOR_CLOSE);
            this.nextSystemState = FrameWorkStates.STATE_SYSTEM_INSTRUCTIONS;
        }

        public systemInstructions(): void {
            this.addChild(this.instructionsScreen);
            this.instructionsScreen.addEventListener(CustomEventButtonId.BUTTON_ID, okButtonClickListener, false, 0, true);
            this.switchSystemState(FrameWorkStates.STATE_SYSTEM_WAIT_FOR_CLOSE);
            this.nextSystemState = FrameWorkStates.STATE_SYSTEM_NEW_GAME;
        }

        public systemNewGame(): void {
            this.addChild(this.game);
            this.game.addEventListener(CustomEventScoreBoardUpdate.UPDATE_TEXT, scoreBoardUpdateListener, false, 0, true);
            this.game.addEventListener(CustomEventLevelScreenUpdate.UPDATE_TEXT, levelScreenUpdateListener, false, 0, true);
            this.game.addEventListener(Game.GAME_OVER, gameOverListener, false, 0, true);
            this.game.addEventListener(Game.NEW_LEVEL, newLevelListener, false, 0, true);
            this.game.newGame();
            this.switchSystemState(FrameWorkStates.STATE_SYSTEM_NEW_LEVEL);
        }

        public systemNewLevel(): void {
            this.game.newLevel();
            this.switchSystemState(FrameWorkStates.STATE_SYSTEM_LEVEL_IN);
        }

        public systemLevelIn(): void {
            this.addChild(this.levelInScreen);
            this.waitTime = 30;
            this.switchSystemState(FrameWorkStates.STATE_SYSTEM_WAIT);
            this.nextSystemState = FrameWorkStates.STATE_SYSTEM_GAME_PLAY;
            addEventListener(EVENT_WAIT_COMPLETE, waitCompleteListener, false, 0, true);
        }

        public systemGameOver(): void {
            this.removeChild(this.game);
            this.addChild(this.gameOverScreen);
            this.gameOverScreen.addEventListener(CustomEventButtonId.BUTTON_ID, okButtonClickListener, false, 0, true);
            this.switchSystemState(FrameWorkStates.STATE_SYSTEM_WAIT_FOR_CLOSE);
            this.nextSystemState = FrameWorkStates.STATE_SYSTEM_TITLE;
        }

        public systemGamePlay(): void {
            this.game.runGame();
        }

        public systemWaitForClose(): void {
            //do nothing
             }
        public systemWait(): void {
                this.waitCount ++;
            if (this.waitCount > this.waitTime) {
                this.waitCount = 0;
                dispatchEvent(new Event(EVENT_WAIT_COMPLETE));
            }
        }
        public okButtonClickListener(e : CustomEventButtonId ): void {
                switch(e.id ) {
            case FrameWorkStates.STATE_SYSTEM_TITLE :
                this.removeChild(this.titleScreen);
                this.titleScreen.removeEventListener(CustomEventButtonId.BUTTON_ID, okButtonClickListener);
                break;
            case FrameWorkStates.STATE_SYSTEM_INSTRUCTIONS :
                this.removeChild(this.instructionsScreen);
                this.instructionsScreen.removeEventListener(CustomEventButtonId.BUTTON_ID, okButtonClickListener);
                break;
            case FrameWorkStates.STATE_SYSTEM_GAME_OVER :
                this.removeChild(this.gameOverScreen);
                this.gameOverScreen.removeEventListener(CustomEventButtonId.BUTTON_ID, okButtonClickListener);
                break;
            }
            this.switchSystemState(this.nextSystemState);
        }
        public scoreBoardUpdateListener(e : CustomEventScoreBoardUpdate ): void {
                this.scoreBoard.update(e.element, e.value);
        }
        public levelScreenUpdateListener(e : CustomEventLevelScreenUpdate ):
            void {
                this.levelInScreen.setDisplayText(levelInText + e.text);
        }

            //gameOverListener listens for Game.GAMEOVER simple
            // custom events calls and changes state accordingly
        public gameOverListener(e : Event ): void {
            this.switchSystemState(FrameWorkStates.STATE_SYSTEM_GAME_OVER ) ;
            this.game.removeEventListener(CustomEventScoreBoardUpdate.UPDATE_TEXT, scoreBoardUpdateListener);
            this.game.removeEventListener(CustomEventLevelScreenUpdate.UPDATE_TEXT, levelScreenUpdateListener);
            this.game.removeEventListener(Game.GAME_OVER, gameOverListener);
            this.game.removeEventListener(Game.NEW_LEVEL, newLevelListener);
        }
            //newLevelListener listens for Game.NEWLEVEL
            // simple custom events calls and changes state accordingly
        public newLevelListener(e : Event ): void {
                this.switchSystemState(FrameWorkStates.STATE_SYSTEM_NEW_LEVEL )
        }
        public waitCompleteListener(e : Event ): void {
                switch(this.lastSystemState) {
                case
                    FrameWorkStates.STATE_SYSTEM_LEVEL_IN :
                    this.removeChild(this.levelInScreen);
                    break
                }
                this.removeEventListener(EVENT_WAIT_COMPLETE, waitCompleteListener);
            this.switchSystemState(this.nextSystemState);
        }
        }
}