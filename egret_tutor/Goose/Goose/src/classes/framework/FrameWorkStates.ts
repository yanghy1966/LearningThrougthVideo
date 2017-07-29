// FrameWorkStates.ts

module goose{
    export class FrameWorkStates{
        public static STATE_SYSTEM_WAIT_FOR_CLOSE:number = 0;
        public static STATE_SYSTEM_TITLE:number = 1;
        public static STATE_SYSTEM_INSTRUCTIONS:number = 2;
        public static STATE_SYSTEM_NEW_GAME:number = 3;
        public static STATE_SYSTEM_GAME_OVER:number = 4;
        public static STATE_SYSTEM_NEW_LEVEL:number = 5;
        public static STATE_SYSTEM_LEVEL_IN:number = 6;
        public static STATE_SYSTEM_GAME_PLAY:number = 7;
        public static STATE_SYSTEM_LEVEL_OUT:number = 8;
        public static STATE_SYSTEM_WAIT:number = 9;
    }
}