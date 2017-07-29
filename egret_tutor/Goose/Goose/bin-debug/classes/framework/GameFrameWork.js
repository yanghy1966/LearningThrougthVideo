// GameFrameWork.ts
var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
var __extends = (this && this.__extends) || function (d, b) {
    for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];
    function __() { this.constructor = d; }
    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
};
var goose;
(function (goose) {
    var GameFrameWork = (function (_super) {
        __extends(GameFrameWork, _super);
        function GameFrameWork() {
            var _this = _super.call(this) || this;
            console.log('ok');
            return _this;
        }
        return GameFrameWork;
    }(egret.DisplayObjectContainer));
    goose.GameFrameWork = GameFrameWork;
    __reflect(GameFrameWork.prototype, "goose.GameFrameWork");
})(goose || (goose = {}));
