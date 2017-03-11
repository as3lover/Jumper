/**
 * Created by mkh on 2017/03/11.
 */
package screens
{
import starling.display.Image;
import starling.display.Sprite;

public class HeroGraphic extends Sprite
{
    private var _image:Image;
    public function HeroGraphic()
    {
        super();
        _image = Game.getImage('wikiwook')
        _image.pivotY = +Config.HERO_RADIUS*2;
        _image.y = +Config.HERO_RADIUS*2;
        addChild(_image);
    }

    public function get ScaleY():Number
    {
        return _image.scaleY;
    }

    public function set ScaleY(value:Number):void
    {
        _image.scaleY = value;
    }
}
}
