/**
 * Created by yanghy on 2017/7/29.
 */
module goose{

    export class RectWithColor extends egret.Sprite{
        rect:egret.Shape;

        constructor(width: number, height: number,
                    isTransparent: boolean , color: number ){

            let alpha: number = isTransparent ? 0:1;

            this.rect = new egret.Shape();
            this.rect.graphics.beginFill(color,alpha);
            this.rect.graphics.drawRect(0,0,width,height);
            this.graphics.endFill();
        }
    }
}