/**
 * Created by mkh on 2017/03/11.
 */
package screens
{
import com.greensock.TweenLite;

import starling.display.Image;
import starling.display.MovieClip;
import starling.display.Sprite;
import starling.events.Event;

public class HeroGraphic extends Sprite
{
    private var _image:Image;
    private var _chiling:MovieClip;
    private var _chilingReversed:Boolean = false;
    private var _ballon:Image;
    private var _holder:Sprite;
    public function HeroGraphic()
    {
        super();
        _image = Game.getImage('wikiwook')

        _holder = new Sprite();
        addChild(_holder)
        _holder.pivotY = +Config.HERO_HEIGTH;
        _holder.y = +Config.HERO_HEIGTH;

        _holder.pivotX = +Config.HERO_WIDTH/2;
        _holder.x = +Config.HERO_WIDTH/2;
        _holder.addChild(_image);

        _chiling = Game.assets._bird;
        _chiling.width = Config.HERO_WIDTH;
        _chiling.height = Config.HERO_HEIGTH;

        _ballon = Game.getImage('balloon')
        _ballon.width = 100;
        _ballon.height = 95;
        _ballon.x = -50;
        _ballon.y = -50;
    }

    public function get ScaleY():Number
    {
        return _holder.scaleY;
    }

    public function set ScaleY(value:Number):void
    {
        _holder.scaleY = value;
    }

    public function get ScaleX():Number
    {
        return _holder.scaleX;
    }

    public function set ScaleX(value:Number):void
    {
        _holder.scaleX = value;
    }

    public function jumping():void
    {
        _ballon.removeFromParent();

        if(_chilingReversed)
            reversChili();

        _holder.addChild(_chiling);
        _chiling.stop();
        _chiling.play();
        _chiling.addEventListener(Event.COMPLETE, pauseChili);

    }

    private function pauseChili(event:Event):void
    {
        _chiling.removeEventListener(Event.COMPLETE, pauseChili);
        _chiling.pause();
    }

    private function reversChili():void
    {
        _chilingReversed = !_chilingReversed;
        _chiling.reverseFrames();
    }

    public function reverseChiling():void
    {
        if(!_chilingReversed)
            reversChili();

        _chiling.addEventListener(Event.COMPLETE, stopChiling);
        _chiling.play();
    }

    public function stopChiling():void
    {
        _chiling.removeEventListener(Event.COMPLETE, stopChiling);
        _chiling.stop();
        _chiling.removeFromParent();
        _holder.addChild(_image)

    }


    public function normal():void
    {
        if(_ballon.parent)
            TweenLite.to(_ballon,.3,{alpha:0, onComplete:_ballon.removeFromParent});
        _chiling.removeFromParent();
        _holder.addChild(_image);
    }

    public function ballon():void
    {
        _ballon.alpha = 0;
        TweenLite.to(_ballon,.3,{alpha:1});
        _holder.addChildAt(_ballon,0);
    }


}
}
