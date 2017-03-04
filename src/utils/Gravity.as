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
    private static var _obj:Object;


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
            _obj = _objects[i];
            if(!_obj.chaned)
            {
                _obj.speedY += Config.ACCEL * _obj.density * time;
                movement = time * _obj.speedY;
                if (movement < 0)
                    _obj.direction = Config.UPWARD;
                else if (movement == 0)
                    _obj.direction = Config.FIXED;
                else
                    _obj.direction = Config.DOWNWARD;

                _obj.y += movement;
            }

            if()
            _obj.x += _obj.speedX * time;
        }
    }
}
}
