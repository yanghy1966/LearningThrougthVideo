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
            let appBackBitmapData = new egret.BitmapData(width, height, isTransparent, color);
            let appBackBitmap = new egret.Bitmap(appBackBitmapData);
            this.addChild(appBackBitmap);
        }

        /*
        // start Timer
        public startTimer(): void {
            timerPeriod = 1000 / frameRate;
            gameTimer = new egret.Timer(timerPeriod);
            gameTimer.addEventListener(egret.TimerEvent.TIMER, this.runGame);
            gemeTimer.start();
        }

        public runGame(e: egret.TimerEvent): void {
            systemFunction();
            e.updateAfterEvent();
        }

        public switchSystemState(stateval: number): void {
            lastSystemState = currentSystemState;
            currentSystemState = stateval;
            switch (stateval) {
                case FrameWorkStates.STATE_SYSTEM_WAIT:
                    systemFunction = systemWait;
                    break;
                case FrameWorkStates.STATE_SYSTEM_WAIT_FOR_CLOSE:
                    systemFunction = systemWaitForClose;
                    break;
                case FrameWorkStates.STATE_SYSTEM_TITLE:
                    systemFunction = systemTitle;
                    break;
                case FrameWorkStates.STATE_SYSTEM_INSTRUCTIONS:
                    systemFunction = systemInstructions;
                    break;
                case FrameWorkStates.STATE_SYSTEM_NEW_GAME:
                    systemFunction = systemNewGame;
                    break;
                case FrameWorkStates.STATE_SYSTEM_NEW_LEVEL:
                    systemFunction = systemNewLevel;
                    break;
                case FrameWorkStates.STATE_SYSTEM_LEVEL_IN:
                    systemFunction = systemLevelIn;
                    break;
                case FrameWorkStates.STATE_SYSTEM_GAME_PLAY:
                    systemFunction = systemGamePlay;
                    break;
                case FrameWorkStates.STATE_SYSTEM_GAME_OVER:
                    systemFunction = systemGameOver;
                    break;
            }
        }// end

        public systemTitle(): void {
            this.addChild(titleScreen);
            titleScreen.addEventListener(CustomEventButtonId.BUTTON_ID, okButtonClickListener, false, 0, true);
            switchSystemState(FrameWorkStates.STATE_SYSTEM_WAIT_FOR_CLOSE);
            nextSystemState = FrameWorkStates.STATE_SYSTEM_INSTRUCTIONS;
        }

        public systemInstructions(): void {
            this.addChild(instructionsScreen);
            instructionsScreen.addEventListener(CustomEventButtonId.BUTTON_ID, okButtonClickListener, false, 0, true);
            switchSystemState(FrameWorkStates.STATE_SYSTEM_WAIT_FOR_CLOSE);
            nextSystemState = FrameWorkStates.STATE_SYSTEM_NEW_GAME;
        }

        public systemNewGame(): void {
            addChild(game);
            game.addEventListener(CustomEventScoreBoardUpdate.UPDATE_TEXT, scoreBoardUpdateListener, false, 0, true);
            game.addEventListener(CustomEventLevelScreenUpdate.UPDATE_TEXT, levelScreenUpdateListener, false, 0, true);
            game.addEventListener(Game.GAME_OVER, gameOverListener, false, 0, true);
            game.addEventListener(Game.NEW_LEVEL, newLevelListener, false, 0, true);
            game.newGame();
            switchSystemState(FrameWorkStates.STATE_SYSTEM_NEW_LEVEL);
        }

        public systemNewLevel(): void {
            game.newLevel();
            switchSystemState(FrameWorkStates.STATE_SYSTEM_LEVEL_IN);
        }

        public systemLevelIn(): void {
            addChild(levelInScreen);
            waitTime = 30;
            switchSystemState(FrameWorkStates.STATE_SYSTEM_WAIT);
            nextSystemState = FrameWorkStates.STATE_SYSTEM_GAME_PLAY;
            addEventListener(EVENT_WAIT_COMPLETE, waitCompleteListener, false, 0, true);
        }

        public systemGameOver(): void {
            removeChild(game);
            addChild(gameOverScreen);
            gameOverScreen.addEventListener(CustomEventButtonId.BUTTON_ID, okButtonClickListener, false, 0, true);
            switchSystemState(FrameWorkStates.STATE_SYSTEM_WAIT_FOR_CLOSE);
            nextSystemState = FrameWorkStates.STATE_SYSTEM_TITLE;
        }

        public systemGamePlay(): void {
            game.runGame();
        }

        public systemWaitForClose(): void {
            //do nothing
            // }
        public
            systemWait()
        :
            void {
                waitCount++;
            if (waitCount > waitTime) {
                waitCount = 0;
                dispatchEvent(new Event(EVENT_WAIT_COMPLETE));
            }
        }
        public
            okButtonClickListener(e
        :
            CustomEventButtonId
        ):
            void {
                switch(e.id
        )
            {
            case
                FrameWorkStates.STATE_SYSTEM_TITLE
            :
                removeChild(titleScreen);
                titleScreen.removeEventListener(CustomEventButtonId.BUTTON_ID, okButtonClickListener);
                break;
            case
                FrameWorkStates.STATE_SYSTEM_INSTRUCTIONS
            :
                removeChild(instructionsScreen);
                instructionsScreen.removeEventListener(CustomEventButtonId.BUTTON_ID, okButtonClickListener);
                break;
            case
                FrameWorkStates.STATE_SYSTEM_GAME_OVER
            :
                removeChild(gameOverScreen);
                gameOverScreen.removeEventListener(CustomEventButtonId.BUTTON_ID, okButtonClickListener);
                break;
            }
            switchSystemState(nextSystemState);
        }
        public
            scoreBoardUpdateListener(e
        :
            CustomEventScoreBoardUpdate
        ):
            void {
                scoreBoard.update(e.element, e.value);
        }
        public
            levelScreenUpdateListener(e
        :
            CustomEventLevelScreenUpdate
        ):
            void {
                levelInScreen.setDisplayText(levelInText + e.text);
        }

            //gameOverListener listens for Game.GAMEOVER simple
            // custom events calls and changes state accordingly
        public
            gameOverListener(e
        :
            Event
        ):
            void {switchSystemState(FrameWorkStates.STATE_SYSTEM_GAME_OVER
        )
            ;
            game.removeEventListener(CustomEventScoreBoardUpdate.UPDATE_TEXT, scoreBoardUpdateListener);
            game.removeEventListener(CustomEventLevelScreenUpdate.UPDATE_TEXT, levelScreenUpdateListener);
            game.removeEventListener(Game.GAME_OVER, gameOverListener);
            game.removeEventListener(Game.NEW_LEVEL, newLevelListener);
        }
            //newLevelListener listens for Game.NEWLEVEL
            // simple custom events calls and changes state accordingly
        public
            newLevelListener(e
        :
            Event
        ):
            void {
                switchSystemState(FrameWorkStates.STATE_SYSTEM_NEW_LEVEL
        )

        }
        public
            waitCompleteListener(e
        :
            Event
        ):
            void {
                switch(lastSystemState) {
                case
                    FrameWorkStates.STATE_SYSTEM_LEVEL_IN
                :
                    removeChild(levelInScreen);
                    break
                }

                removeEventListener(EVENT_WAIT_COMPLETE, waitCompleteListener);
            switchSystemState(nextSystemState);

        }


        }

         */
    }

}