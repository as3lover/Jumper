/**
 * Created by SalmanPC3 on 3/4/2017.
 */
package utils
{

import flash.geom.Point;

import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.utils.rad2deg;

public class TouchHandler
{
    private var _startPoint:Point;
    private var _touchNum:int;
    private var _move:String;
    private var _moving:Boolean;
    private var _distance:Number;
    private var _degrees:Array;
    private var _touchArea;
    private var _setMove:Function;

    private static var _status:String;

    public function TouchHandler(touchArea, setMoveFunction)
    {
        _touchArea = touchArea;
        _setMove = setMoveFunction;
        _touchArea.addEventListener(TouchEvent.TOUCH, onTouch);
    }

    private function onTouch(event:TouchEvent):void
    {
        var localPos:Point;

        var touch:Touch = event.getTouch(_touchArea, TouchPhase.BEGAN);
        if (touch)
        {
            set_status = TouchPhase.BEGAN;
            _moving = false;
            _startPoint = touch.getLocation(_touchArea);
            _touchNum = 0;
            _degrees = new Array();
            _distance = 0;
            //trace('start',_startPoint);
            _touchArea.addEventListener(Event.ENTER_FRAME, onEnterFrame);
            return
        }



        touch = event.getTouch(_touchArea, TouchPhase.MOVED);
        if (touch)
        {
            set_status = TouchPhase.MOVED;

            if (_moving)
                return;

            localPos = touch.getLocation(_touchArea);
            _distance += DistanceTwoPoints(_startPoint, localPos);
            _degrees.push(getAngleFromPoints(_startPoint, localPos));
            _startPoint = localPos;
            //trace('move',_startPoint)
            if (_degrees.length > 4)
            {
                calcDegree(_degrees);
            }
            return;
        }

        touch = event.getTouch(_touchArea, TouchPhase.ENDED);
        if (touch)
        {

            set_status = TouchPhase.ENDED;

            if (_moving)
                return;
            _touchArea.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
            localPos = touch.getLocation(_touchArea);
            _degrees.push(getAngleFromPoints(_startPoint, localPos));
            //trace('end',_startPoint)

            if (_distance < -10 && _distance > +10)
            {
                calcDegree(_degrees);
            }
            else if (_touchNum <= 12)
            {
                if (_startPoint)
                {
                    if (_startPoint.x > 400)
                        move = RIGHT_UP;
                    else
                        move = LEFT_UP;
                }
            }

            return;
        }

        touch = event.getTouch(_touchArea, TouchPhase.HOVER);
        if (touch)
        {
            set_status = TouchPhase.HOVER;
            return;
        }

        touch = event.getTouch(_touchArea, TouchPhase.STATIONARY);
        if (touch)
        {
            set_status = TouchPhase.STATIONARY;
            return;
        }
    }

    public function set set_status(a):void
    {
        _status = a;
        //trace('TouchPhase:',a)
    }


    private function calcDegree(degs:Array):void
    {
        var sum:int = 0;
        var len:int = degs.length;
        for (var i:int = 0; i<len; i++)
        {
            sum += degs[i]
        }
        sum /= len;
        calcDirection(sum);
    }

    private function calcDirection(deg:int):void
    {
        var dir:String;

        if(deg <= 22.5)
            dir = RIGHT;
        else if(deg <=45+22.5)
            dir = RIGHT_UP;
        else if(deg <=90+22.5)
            dir = UP;
        else if(deg <=180-22.5)
            dir = LEFT_UP;
        else
            dir = LEFT;

        move = dir;
    }

    private function DistanceTwoPoints(p1:Point, p2:Point):Number
    {
        var dx:Number = p1.x-p2.x;
        var dy:Number = p1.y-p2.y;
        return Math.sqrt(dx * dx + dy * dy);
    }

    private function getAngleFromPoints(p1:Point,p2:Point):Number
    {
        return getAngle(p1.x, p1.y, p2.x, p2.y)
    }

    private function getAngle (x1:Number, y1:Number, x2:Number, y2:Number):Number
    {
        var dx:Number = x2 - x1;
        var dy:Number = y2 - y1;
        var angle:Number = rad2deg(Math.atan2(dy,dx));

        if(angle <= 0)
            angle = -angle;
        else if(angle < 90)
            angle = 0;
        else
            angle = 180;

        return angle;
    }


    private function onEnterFrame(event:Event):void
    {
        _touchNum++;

        if(_startPoint && _touchNum > 12)
        {
            if(_startPoint.x > 400)
                move = TO_RIGTH;
            else
                move = TO_LEFT;
        }
    }


    public function get move():String
    {
        return _move;
    }

    public function set move(value:String):void
    {
        _move = value;
       _setMove(value);

        if (value == TO_LEFT || value == TO_RIGTH)
        {

        }
        else
        {
            _touchArea.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
            _moving = true;
        }
    }

    private function get RIGHT_UP():String
    {
        return Config.RIGHT_UP;
    }

    private function get RIGHT():String
    {
        return Config.RIGHT;
    }

    private function get LEFT_UP():String
    {
        return Config.LEFT_UP;
    }

    private function get LEFT():String
    {
        return Config.LEFT;
    }

    private function get TO_LEFT():String
    {
        return Config.TO_LEFT;
    }

    private function get TO_RIGTH():String
    {
        return Config.TO_RIGTH;
    }

    private function get UP():String
    {
        return Config.UP;
    }

    public static function get status():String
    {
        return _status;
    }

}
}
