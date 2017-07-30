// GameFrameWork.ts

module goose {
    export class BasicScreen extends egret.Sprite {
        public constructor() {
            super();
        }

        private displayText: egret.TextField = new egret.TextField();
        //private backgroundBitmapData: BitmapData;
        //private backgroundBitmap: Bitmap;
        private okButton: SimpleBlitButton;

        //ID is passed into the constructor. When the OK button is
        // clicked,a custom event sends this id back to Main
        private id: number;

        public BasicScreen(id: number, width: number, height: number, isTransparent: boolean, color: number) {
            this.id = id;
            //this.backgroundBitmapData = new BitmapData(width, height, IsTransparent, color);
            //this.backgroundBitmap = new Bitmap(this.backgroundBitmapData);
            //this.addChild(this.backgroundBitmap);
            let rect: egret.Sprite = new goose.RectWithColor(width,height,isTransparent,color);
            this.addChild(rect);
        }

        public createDisplayText(text: String, width: Number, location: Point, textFormat: TextFormat): void {
            this.displayText.y = location.y;
            this.displayText.x = location.x;
            this.displayText.width = width;
            this.displayText.defaultTextFormat = textFormat;
            this.displayText.text = text;
            this.addChild(this.displayText);
        }

        public createOkButton(text: String, location: Point, width: Number, height: Number,
                              textFormat: TextFormat, offColor: number = 0x000000, overColor: number = 0xff0000, positionOffset: Number = 0): void {
            this.okButton = new SimpleBlitButton(location.x, location.y, width, height, text, 0xffffff, 0xff0000, textFormat, positionOffset);
            this.addChild(this.okButton);
            this.okButton.addEventListener(MouseEvent.MOUSE_OVER, okButtonOverListener, false, 0, true);
            this.okButton.addEventListener(MouseEvent.MOUSE_OUT, okButtonOffListener, false, 0, true);
            this.okButton.addEventListener(MouseEvent.CLICK, okButtonClickListener, false, 0, true);
        }

        public setDisplayText(text: String): void {
            this.displayText.text = text;
        }

        //Listener functions
// okButtonClicked fires off a custom event and sends the //"id" to the listener.
        private okButtonClickListener(e: MouseEvent): void {
            dispatchEvent(new CustomEventButtonId(CustomEventButtonId.BUTTON_ID, id));
        }

        private okButtonOverListener(e: MouseEvent): void {
            this.okButton.changeBackGroundColor(SimpleBlitButton.OVER);
        }

        private okButtonOffListener(e: MouseEvent): void {
            this.okButton.changeBackGroundColor(SimpleBlitButton.OFF);
        }
    }
}