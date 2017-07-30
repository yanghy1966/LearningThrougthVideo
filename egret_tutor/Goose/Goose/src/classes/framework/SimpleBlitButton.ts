/**
 * Created by yanghy on 2017/7/30.
 */
module goose {
    export class SimpleBlitButton extends egret.Sprite {
        public static OFF:number = 1;
        public static OVER:number = 2;
        //all buttons backgrounds.
        //using a simple Bitmapdata rectangle to create the white and red button background states
        private offBackGroundBD:egret.BitmapData;
        private overBackGroundBD:egret.BitmapData;

        private positionOffset:number;

        //OK button
        //The OK button is made up of a Bitmap of the text and a bitmap of the background layered onto one another.
        //They both are layerd into a Sprite to get Click events

        private buttonBackGroundBitmap:egret.Bitmap;
        private buttonTextBitmapData:egret.BitmapData;
        private buttonTextBitmap:egret.Bitmap;


        public constructor (x:number,y:number,width:number,height:number, text:string, offColor:number, overColor:number,
                            textformat:goose.TextFormat, positionOffset:number=0)
    {
        this.positionOffset = positionOffset;
        this.x = x;
        this.y = y;
        //background
        this.offBackGroundBD = new egret.BitmapData(width, height, false, offColor);
        this.overBackGroundBD = new egret.BitmapData(width, height, false, overColor);
        this.buttonBackGroundBitmap = new egret.Bitmap(this.offBackGroundBD);

        //text
        var tempText:egret.TextField = new egret.TextField();
        tempText.text = text;
        tempText.setTextFormat(textformat);

        buttonTextBitmapData  = new BitmapData(tempText.textWidth+positionOffset,tempText.textHeight+positionOffset, true, 0x00000000);
        buttonTextBitmapData.draw(tempText);
        buttonTextBitmap = new Bitmap(buttonTextBitmapData);

        buttonTextBitmap.x = ((buttonBackGroundBitmap.width - tempText.textWidth)/2)-positionOffset;
        buttonTextBitmap.y = ((buttonBackGroundBitmap.height - tempText.textHeight)/2)-positionOffset;


        this.addChild(buttonBackGroundBitmap);
        this.addChild(buttonTextBitmap);
        this.buttonMode = true;
        this.useHandCursor = true;
    }

        public changeBackGroundColor(typeval:number):void {
        if (typeval == goose.SimpleBlitButton.OFF) {
            buttonBackGroundBitmap.bitmapData = offBackGroundBD;
        }else {
            buttonBackGroundBitmap.bitmapData = overBackGroundBD;
        }
    }


    }

}
