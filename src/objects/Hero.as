/**
 * Created by mkh on 2017/03/11.
 */
package objects
{
import Physics.HeroBody;

import screens.GameArea;

import screens.HeroGraphic;

import starling.display.DisplayObject;

public class Hero
{
    private var _hero:HeroBody;
    private static var JUMP:int = 0;
    private static var _jumping:Boolean;

    public function Hero(hero:HeroBody, graphic:DisplayObject=null)
    {
        _hero = hero;
        _hero.type = Config.HERO;
        if(graphic != null)
        {
            _hero.graphic = graphic;
        }
    }

    public function get x():Number{return _hero.x}
    public function get y():Number{return _hero.y}
    public function get rotation():Number{return _hero.rotation}
    public function get speedX():Number{return _hero.speedX}
    public function get speedY():Number{return _hero.speedY}
    public function get graphic():DisplayObject{return _hero.graphic}

    public function set x(x:Number):void{_hero.x = x}
    public function set y(y:Number):void{_hero.y = y}
    public function set rotation(rotation:Number):void{_hero.rotation = rotation}
    public function set speedX(speedX:Number):void{_hero.speedX = speedX}

    public function set graphic(graphic:DisplayObject):void{_hero.graphic = graphic}

    public function set speedY(speedY:Number):void
    {
        if(!_jumping)
            _hero.speedY = speedY
        else
        {
            JUMP--;

            with(HeroGraphic(graphic))
            {
                if(JUMP > 150)
                {
                    ScaleY *= .99;
                    return
                }
                else if(ScaleY < 1)
                {
                    ScaleY *= 1.05;

                    if( ScaleY > 1)
                        ScaleY = 1;
                }
            }

           _hero.speedY = Config.HERO_JUMPING_SPEED * (JUMP/120);

            graphic.parent.parent.x = (-0.5 + Math.random()) * JUMP/20;
            graphic.parent.parent.y = (-0.5 + Math.random()) * JUMP/20;

            if(JUMP < 1)
            {
                _jumping = false;
                graphic.parent.parent.x = graphic.parent.parent.y = 0;
            }
            else if(JUMP == 149)
            {
                speedX = 0;
            }


        }
    }


    public function move(dir:String):void
    {
        if(jumping)
        {
            if(dir == Config.TO_LEFT)
            {
                speedX = - Config.HERO_X_SPEED_JUMPING;
            }
            else if(dir == Config.TO_RIGTH)
            {
                speedX = Config.HERO_X_SPEED_JUMPING;
            }
            return;
        }
        switch (dir)
        {
            case Config.UP:
                //speedX = 100;
                speedY = Config.HERO_UP_Y_SPEED;
                break;

            case Config.LEFT:
                speedX = Config.HERO_LEFT_X_SPEED;
                speedY = Config.HERO_LEFT_Y_SPEED;
                break;

            case Config.RIGHT:
                speedX = Config.HERO_RIGHT_X_SPEED;
                speedY = Config.HERO_RIGHT_Y_SPEED;
                break;

            case Config.LEFT_UP:
                speedX = Config.HERO_LEFT_UP_X_SPEED;
                speedY = Config.HERO_LEFT_UP_Y_SPEED;
                break;

            case Config.RIGHT_UP:
                speedX = Config.HERO_RIGHT_UP_X_SPEED;
                speedY = Config.HERO_RIGHT_UP_Y_SPEED;
                break;

            case Config.TO_LEFT:
                speedX = Config.HERO_TO_LEFT_X_SPEED
                break;

            case Config.TO_RIGTH:
                speedX = Config.HERO_TO_RIGHT_X_SPEED;
                break;


        }
    }

    public static function chili():void
    {
        JUMP = 180;
        _jumping = true;
    }

    public function get jumping():Boolean
    {
        return _jumping;
    }

    public function get jumps():int
    {
        return JUMP;
    }

}
}
