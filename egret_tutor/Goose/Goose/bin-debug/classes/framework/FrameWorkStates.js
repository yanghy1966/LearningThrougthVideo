// FrameWorkStates.ts
var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
var goose;
(function (goose) {
    var FrameWorkStates = (function () {
        function FrameWorkStates() {
        }
        return FrameWorkStates;
    }());
    FrameWorkStates.STATE_SYSTEM_WAIT_FOR_CLOSE = 0;
    FrameWorkStates.STATE_SYSTEM_TITLE = 1;
    FrameWorkStates.STATE_SYSTEM_INSTRUCTIONS = 2;
    FrameWorkStates.STATE_SYSTEM_NEW_GAME = 3;
    FrameWorkStates.STATE_SYSTEM_GAME_OVER = 4;
    FrameWorkStates.STATE_SYSTEM_NEW_LEVEL = 5;
    FrameWorkStates.STATE_SYSTEM_LEVEL_IN = 6;
    FrameWorkStates.STATE_SYSTEM_GAME_PLAY = 7;
    FrameWorkStates.STATE_SYSTEM_LEVEL_OUT = 8;
    FrameWorkStates.STATE_SYSTEM_WAIT = 9;
    goose.FrameWorkStates = FrameWorkStates;
    __reflect(FrameWorkStates.prototype, "goose.FrameWorkStates");
})(goose || (goose = {}));
