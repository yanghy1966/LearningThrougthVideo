// GameFrameWork.ts

class Main extends goose.GameFrameWork {
    public static SCORE_BOARD_CLICKS: string = "clicked";
    public constructor() {
        super();
        //this.init();
    }

    /*
    public init(): void {
        this.game = new goose.StubGame();
        this.setApplicationBackGround(400,400,false,0x000000);
        //add score board to the screen as the seconf layer
        let scoreBoard = new ScoreBoard();
        this.addChild(scoreBoard);

        scoreBoardTextFormat= new TextFormat("_sans", "11", "0xffffff", "true");
        scoreBoard.createTextElement(SCORE_BOARD_CLICKS,
            new SideBySideScoreElement(25, 5, 15, "Clicks",
                scoreBoardTextFormat, 25, "0",scoreBoardTextFormat));

//screen text initializations
 screenTextFormat = new TextFormat("_sans", "16", "0xffffff", "false");
 screenTextFormat.align = flash.text.TextFormatAlign.CENTER;
 screenButtonFormat = new TextFormat("_sans", "12", "0x000000", "false");
        titleScreen = new BasicScreen(FrameWorkStates.STATE_SYSTEM_TITLE,400,400,false,0x0000dd );
        titleScreen.createOkButton("OK", new Point(170, 250), 40, 20, screenButtonFormat, 0x000000, 0xff0000,2); titleScreen.createDisplayText("Stub Game", 100,new Point(145,150),screenTextFormat); instructionsScreen = new BasicScreen(FrameWorkStates.STATE_SYSTEM_INSTRUCTIONS,400,400, false,0x0000dd); instructionsScreen.createOkButton("Play", new Point(150, 250), 80, 20,screenButtonFormat, 0x000000, 0xff0000,2); instructionsScreen.createDisplayText("Click the mouse\n10 times",150,new Point(120,150),ˇ
        screenTextFormat);
        gameOverScreen = new BasicScreen(FrameWorkStates.STATE_SYSTEM_GAME_OVER,400,400,false,0x0000dd); gameOverScreen.createOkButton("OK", new Point(170, 250),40, 20,screenButtonFormat, 0x000000, 0xff0000,2); gameOverScreen.createDisplayText("Game Over",100,newPoint(140,150),screenTextFormat); levelInScreen = new BasicScreen(FrameWorkStates.STATE_SYSTEM_LEVEL_IN, 400, 400, true, 0xaaff0000);

        levelInText = "Level "; levelInScreen.createDisplayText(levelInText,100,new

            Point(150,150),screenTextFormat); //Set standard wait time between levels waitTime= 30; //set initial game state switchSystemState(FrameWorkStates.STATE_SYSTEM_TITLE); //create timer and run it one time frameRate = 30; startTimer(); }


    }
    */
}

