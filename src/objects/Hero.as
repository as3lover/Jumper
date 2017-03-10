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
    private var _density:Number;
    private var _chain:Object;
    private var _chained:Boolean;
    private var _walking:Boolean;
    private var _jumping:Boolean;
    private var _distanceX:Number;
    private var _distanceY:Number;
    private var _vFactor:Number ;
    private var _startWalkSpeed:Number ;

    public function Hero()
    {
        var quad:Quad = new Quad(Config.HERO_WIDTH, Config.HERO_HEIGTH, Color.RED)
        quad.x = - Config.HERO_WIDTH / 2;
        quad.y = - Config.HERO_HEIGTH;
        addChild(quad);

        _density = Config.HERO_DENSITY;
        _vFactor = Config.HERO_V_FACTOR;
        _startWalkSpeed = Config.HERO_START_WALK_SPEED;
        _speedX = 0;
        _speedY = 0;

        _jumping = true;
        _walking = false;

        Gravity.add(this);
    }

    public function get speedY():Number
    {
        trace('get speedY',_speedY)
        return _speedY;
    }

    public function set speedY(value:Number):void
    {
        trace('set speedY',value)
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

    public function get jumping():Boolean
    {
        return _jumping;
    }

    public function set jumping(value:Boolean):void
    {
        _jumping = value;

        if(jumping)
        {
            chained = false;
        }
        else
        {
            trace('set jumping', value)
            _direction = Config.FIXED;
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
        if (value == null)
        {

        }
        else
        {
            trace('chain',value)
            speedY = 0;
            distanceX = this.x - _chain.x;
            distanceY = this.y - _chain.y;
            chained = true;
            jumping = false;
        }
    }

    public function move(direction:String):void
    {
        trace("-----MOVE", direction, jumping)
        if(jumping)
            return;

        speedY = - Config.HERO_Y_SPEED;

        switch(direction)
        {
            case Config.RIGHT_UP:
                speedX = Config.HERO_X_SPEED/3.1;
                break;

            case Config.LEFT_UP:
                speedX = -Config.HERO_X_SPEED/3.1;
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

            default:
                    trace('default')
                speedY = 0;
                walk(direction);
                return;
                break;
        }

        walking = false;
        jumping = true;
    }

    public function walk(direction:String)
    {
        if(walking)
                return;

        if(direction == Config.TO_RIGTH)
        {
            speedX = + Config.HERO_START_WALK_SPEED;
        }
        else if(direction == Config.TO_LEFT)
        {
            speedX = - Config.HERO_START_WALK_SPEED;
        }
        else
        {
            trace('wrong hero move direction:', direction);
            return;
        }

        walking = true;
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
        if(!value)
        {
            _chain = null;
            //speedY = 0;
        }
    }

    public function get walking():Boolean
    {
        return _walking;
    }

    public function set walking(value:Boolean):void
    {
        _walking = value;
        if(!value)
        {
            //speedX = 0;
        }
    }



    public function get distanceX():Number
    {
        return _distanceX;
    }

    public function set distanceX(value:Number):void
    {
        _distanceX = value;
    }

    public function get distanceY():Number
    {
        return _distanceY;
    }

    public function set distanceY(value:Number):void
    {
        _distanceY = value;
    }

    public function get vFactor():Number
    {
        return _vFactor;
    }

    public function set vFactor(value:Number):void
    {
        _vFactor = value;
    }

    public function get startWalkSpeed():Number
    {
        return _startWalkSpeed;
    }

    public function set startWalkSpeed(value:Number):void
    {
        _startWalkSpeed = value;
    }
}
}
