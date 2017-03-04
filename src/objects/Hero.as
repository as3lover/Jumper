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
    private var _chained:Boolean;


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

        speedY = - Config.HERO_Y_SPEED;

        switch(direction)
        {
            case Config.RIGHT_UP:
                speedX = Config.HERO_X_SPEED;
                break;

            case Config.LEFT_UP:
                speedX = -Config.HERO_X_SPEED;
                break

            case Config.UP:
                speedX = 0;
                break

            case Config.LEFT:
                speedX = - Config.HERO_X_SPEED;
                speedY = - Config.HERO_Y_SPEED/2;
                break

            case Config.RIGHT:
                speedX = + Config.HERO_X_SPEED;
                speedY = - Config.HERO_Y_SPEED/2;
                break

            case Config.TO_LEFT:
                speedX = - Config.HERO_X_SPEED/10;
                speedY = 0;
                break

            case Config.TO_RIGTH:
                speedX = - Config.HERO_X_SPEED/10;
                speedY = 0;
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

    public function get chained():Boolean
    {
        return _chained;
    }

    public function set chained(value:Boolean):void
    {
        _chained = value;
        if(chained)
        {

        }
    }
}
}
