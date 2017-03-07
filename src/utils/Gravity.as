/**
 * Created by SalmanPC3 on 3/3/2017.
 */
package utils
{
import flash.geom.Rectangle;

import objects.Hero;

import starling.display.DisplayObject;

public class Gravity
{
    private static var _objects:Array = new Array();
    private static var _length:int = 0 ;
    private static var _obj:Object;


    public function Gravity(){}

    public static function add(object:DisplayObject):void
    {
        _objects.push(object);
        _length++;
    }

    public static function advanceTime(time:Number, levels):void
    {
        var movement:Number;

        for(var i:int = 0; i<_length; i++)
        {
            _obj = _objects[i];

            if(_obj.chained)
            {
                if(_obj.walking)
                {
                    _obj.speedX *= _obj.vFactor * time;
                    _obj.distanceX += _obj.speedX * time;
                }

                _obj.x = _obj.distanceX + _obj.chain.x;
                _obj.y = _obj.distanceY + _obj.chain.y;

                if(_obj.walking && !collide(_obj as DisplayObject, _obj.chain as DisplayObject))
                {
                    _obj.chained = false;
                }
            }
            else if (_obj.jumping)
            {
                trace('jumping', _obj , _obj.speedY);
                _obj.speedY += Config.ACCEL * _obj.density * time;
                movement = time * _obj.speedY;

                if (movement < 0)
                    _obj.direction = Config.UPWARD;
                else if (movement == 0)
                    _obj.direction = Config.FIXED;
                else
                    _obj.direction = Config.DOWNWARD;

                _obj.y += movement;

                _obj.x += _obj.speedX * time;
                trace(_obj.direction)
                if(_obj.direction == Config.DOWNWARD)
                {
                    var plane = levels.cllision(_obj);
                    if(plane)
                        _obj.chain = plane;
                }
                //temp
                if(_obj.y > 500)
                {
                    _obj.y = 0;
                    _obj.x = Math.random()*800
                }
                //
            }

        }
    }

    private static function collide(obj1:DisplayObject, obj2:DisplayObject):Boolean
    {
        var rect1:Rectangle = obj1.getBounds(obj1.stage);
        var rect2:Rectangle = obj2.getBounds(obj2.stage);

        return rect1.intersects(rect2);
    }
}
}
