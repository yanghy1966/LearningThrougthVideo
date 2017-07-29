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
    var BasicScreen = (function (_super) {
        __extends(BasicScreen, _super);
        function BasicScreen() {
            return _super.call(this) || this;
        }
        return BasicScreen;
    }(egret.Sprite));
    __reflect(BasicScreen.prototype, "BasicScreen");
    var displayText = new TextField();
    var backgroundBitmapData;
    var backgroundBitmap;
    var okButton;
    //ID is passed into the constructor. When the OK button is
    // clicked,a custom event sends this id back to Main
    var id;
    function BasicScreen(id, width, height, isTransparent, color) {
        this.id = id;
        backgroundBitmapData = new BitmapData(width, height, IsTransparent, color);
        backgroundBitmap = new Bitmap(backgroundBitmapData);
        addChild(backgroundBitmap);
    }
    createDisplayText(text, String, width, Number, location, Point, textFormat, TextFormat);
    void {
        displayText: .y = location.y,
        displayText: .x = location.x,
        displayText: .width = width,
        displayText: .defaultTextFormat = textFormat,
        displayText: .text = text
    };
    function createOkButton(text, location, width, height, textFormat, offColor, overColor, positionOffset) {
        if (offColor === void 0) { offColor = 0x000000; }
        if (overColor === void 0) { overColor = 0xff0000; }
        if (positionOffset === void 0) { positionOffset = 0; }
        okButton = new SimpleBlitButton(location.x, location.y, ˇ, width, height, text, 0xffffff, 0xff0000, textFormat, ˇ, positionOffset);
        addChild(okButton);
        okButton.addEventListener(MouseEvent.MOUSE_OVER, ˇ, okButtonOverListener, false, 0, true);
        okButton.addEventListener(MouseEvent.MOUSE_OUT, ˇ, okButtonOffListener, false, 0, true);
        okButton.addEventListener(MouseEvent.CLICK, ˇ, okButtonClickListener, false, 0, true);
    }
    function setDisplayText(text) { displayText.text = text; } //Listener functions //okButtonClicked fires off a custom event and sends the //"id" to the listener. private function okButtonClickListener(e:MouseEvent):void { dispatchEvent(new CustomEventButtonId(CustomEventButtonId.BUTTON_ID,id));
})(goose || (goose = {}));
function okButtonOverListener(e) { okButton.changeBackGroundColor(SimpleBlitButton.OVER); }
function okButtonOffListener(e) { okButton.changeBackGroundColor(SimpleBlitButton.OFF); }
