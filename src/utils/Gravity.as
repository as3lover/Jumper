/**
 * Created by SalmanPC3 on 3/3/2017.
 */
package utils
{
import starling.display.DisplayObject;

public class Gravity
{
    private static var _objects:Array = new Array();
    private static var _length:int = 0 ;

    public function Gravity(){}

    public static function add(object:DisplayObject):void
    {
        _objects.push(object);
        _length++;
    }

    public static function calculate(time:Number):void
    {
        var movement:Number;
        for(var i:int = 0; i<_length; i++)
        {
            if(_objects[i].moving)
            {
                _objects[i].speedY += Config.ACCEL * _objects[i].density * time;
                movement = time * _objects[i].speedY;
                if (movement < 0)
                    _objects[i].direction = Config.UPWARD;
                else if (movement == 0)
                    _objects[i].direction = Config.FIXED;
                else
                    _objects[i].direction = Config.DOWNWARD;

                _objects[i].y += movement;
                _objects[i].x += _objects[i].speedX * time;
            }
        }
    }
}
}
