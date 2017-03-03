/**
 * Created by SalmanPC3 on 3/3/2017.
 */
package objects
{
import starling.display.Quad;
import starling.display.Sprite;
import starling.utils.Color;

import utils.Gravity;

public class Hero extends Sprite
{
    private var _speedX:Number;
    private var _speedY:Number;
    private var _direction:int;
    private var _moving:Boolean;
    private var _density:Number;
    private var _chain:Object;


    public function Hero()
    {
        var quad:Quad = new Quad(Config.HERO_WIDTH, Config.HERO_HEIGTH, Color.RED)
        quad.x = - Config.HERO_WIDTH / 2;
        quad.y = - Config.HERO_HEIGTH;
        addChild(quad);

        _density = Config.HERO_DENSITY;
        moving = false;

        Gravity.add(this);
    }

    public function get speedY():Number
    {
        return _speedY;
    }

    public function set speedY(value:Number):void
    {
        _speedY = value;
    }

    public function get direction():int
    {
        return _direction;
    }

    public function set direction(value:int):void
    {
        _direction = value;
    }

    public function get moving():Boolean
    {
        return _moving;
    }

    public function set moving(value:Boolean):void
    {
        _moving = value;

        if(moving)
            chain = null;
        else
        {
            _direction = Config.FIXED;
            speedX = 0;
            speedY = 0;
        }

    }

    public function get density():Number
    {
        return _density;
    }

    public function set density(value:Number):void
    {
        _density = value;
    }

    public function get chain():Object
    {
        return _chain;
    }

    public function set chain(value:Object):void
    {
        _chain = value;
    }

    public function move(direction:int):void
    {
        if(moving)
                return;

        speedY = -450

        switch(direction)
        {
            case Config.UP_RIGHT:
                speedX = 150;
                break;

            case Config.UP_LEFT:
                speedX = -150
                break

            case Config.UP:
                speedX = 0;
                speedY = -500
                break
        }


        moving = true;
    }

    public function get speedX():Number
    {
        return _speedX;
    }

    public function set speedX(value:Number):void
    {
        _speedX = value;
    }
}
}
