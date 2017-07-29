// GameFrameWork.ts

module goose {
    class BasicScreen extends egret.Sprite {
        public constructor() {
            super();
        }
    }
    private var displayText:TextField = new TextField();
    private var backgroundBitmapData:BitmapData;
    private var backgroundBitmap:Bitmap;
    private var okButton:SimpleBlitButton;
    //ID is passed into the constructor. When the OK button is
    // clicked,a custom event sends this id back to Main
     private var id:int;
     public function BasicScreen(id:int,width:Number, height:Number,isTransparent:Boolean, color:uint) {
         this.id = id;
         backgroundBitmapData = new BitmapData(width, height,IsTransparent, color);
         backgroundBitmap = new Bitmap(backgroundBitmapData);
         addChild(backgroundBitmap);
     }
    public createDisplayText(text:String,  width:Number, location:Point,textFormat:TextFormat):void {
         displayText.y = location.y;
         displayText.x = location.x;
         displayText.width = width;
         displayText.defaultTextFormat=textFormat;
         displayText.text = text;
         addChild(displayText);
     }
public function createOkButton(text:String,location:Point, width:Number,height:Number,
                               textFormat:TextFormat, offColor:uint=0x000000, overColor:uint=0xff0000, positionOffset:Number=0):void{ okButton = new SimpleBlitButton(location.x, location.y, ˇ width, height, text, 0xffffff, 0xff0000, textFormat,ˇ positionOffset); addChild(okButton); okButton.addEventListener(MouseEvent.MOUSE_OVER,ˇ okButtonOverListener, false,0, true); okButton.addEventListener(MouseEvent.MOUSE_OUT,ˇ okButtonOffListener, false, 0, true); okButton.addEventListener(MouseEvent.CLICK,ˇ okButtonClickListener, false, 0, true); } public function setDisplayText(text:String):void { displayText.text = text; } //Listener functions //okButtonClicked fires off a custom event and sends the //"id" to the listener. private function okButtonClickListener(e:MouseEvent):void { dispatchEvent(new CustomEventButtonId(CustomEventButtonId.BUTTON_ID,id));
} private function okButtonOverListener(e:MouseEvent):void { okButton.changeBackGroundColor(SimpleBlitButton.OVER); } private function okButtonOffListener(e:MouseEvent):void { okButton.changeBackGroundColor(SimpleBlitButton.OFF); } }
}