/**
 * Created by yanghy on 2017/7/30.
 */

module goose {
    export class TextFormat{

        //font:String = null, size:Object = null, color:Object = null, bold:Object = null, italic:Object = null, underline:Object = null, url:String = null, target:String = null, align:String = null, leftMargin:Object = null, rightMargin:Object = null, indent:Object = null, leading:Object = null)
        //screenButtonFormat = new TextFormat("_sans", "12", "0x000000", "false");
        //this.okButton = new SimpleBlitButton(location.x, location.y, width, height, text, 0xffffff, 0xff0000, textFormat, positionOffset);
        // 字体，字号，颜色，黑体？
        public font:string;
        public size:number;
        public color:number;
        public bold:boolean;
        constructor(font:string, size:number,color:number,bold:boolean){
            this.font = font;
            this.size = size;
            this.color = color;
            this.bold = bold;
        }
    }
}
