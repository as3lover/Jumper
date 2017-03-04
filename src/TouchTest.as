/**
 * Created by SalmanPC3 on 3/4/2017.
 */
package
{
import com.greensock.TweenLite;

import flash.geom.Point;

import starling.core.Starling;
import starling.display.Image;

import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.utils.Color;
import starling.utils.rad2deg;

public class TouchTest extends Sprite
{
    var _box:Sprite;
    private var _startPoint:Point;
    private var _touchNum:int;

    private const RIGHT_UP:String = 'RightUp';
    private const LEFT_UP:String = 'LeftUp';
    private const RIGHT:String = 'Right';
    private const LEFT:String = 'Left';
    private const UP:String = 'Up';
    private const TO_LEFT:String = 'toLeft';
    private const TO_RIGTH:String = 'toRight';

    private var _move:String;
    private var _moving:Boolean;
    private var _distanse:Number;
    private var _degrees:Array;
    private var _background:Image;
    private var _speed:Number;

    public function TouchTest(background:Image)
    {
        _background = background;
        this.addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(event:Event):void
    {
        addChild(_background);

        _box = new Sprite();
        var quad:Quad = new Quad(50,50, Color.RED);
        quad.x = -25;
        quad.y = -50;
        _box.addChild(quad);
        addChild(_box);
        //temp
        _box.x = 400;
        _box.y = 400;
        trace(quad.getBounds(stage));
        //
        parent.addEventListener(TouchEvent.TOUCH, onTouch);
    }

    private function onTouch(event:TouchEvent):void
    {
        var localPos:Point;

        var touch:Touch = event.getTouch(this, TouchPhase.BEGAN);
        if (touch)
        {
            TweenLite.killTweensOf(_box);
            _moving = false;
            _startPoint = touch.getLocation(this);
            _box.x = 400;
            _box.y = 400;
            _touchNum = 0;
            _speed = 0;
            _degrees = new Array();
            _distanse = 0;
            trace('start',_startPoint)
            addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }

        if (_moving)
            return;

        touch = event.getTouch(this, TouchPhase.MOVED);
        if (touch)
        {
            localPos = touch.getLocation(this);
            _distanse += DistanceTwoPoints(_startPoint, localPos);
            _degrees.push(getAngleFromPoints(_startPoint, localPos));
            _startPoint = localPos;
            trace('move',_startPoint)
            if (_degrees.length > 4)
            {
                calcDegree(_degrees);
            }
        }

        touch = event.getTouch(this, TouchPhase.ENDED);
        if (touch)
        {
            removeEventListener(Event.ENTER_FRAME, onEnterFrame);
            localPos = touch.getLocation(this);
            _degrees.push(getAngleFromPoints(_startPoint, localPos));
            trace('end',_startPoint)

            if (_distanse < -10 && _distanse > +10)
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
        }
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

        var x:int = _box.x;
        var y:int = _box.y;

        switch (value)
        {
            case UP:
                y -= 300;
                break;

            case LEFT_UP:
                y -= 300;
                x -= 200;
                break;

            case RIGHT_UP:
                y -= 300;
                x += 200;
                break;

            case LEFT:
                x -= 200;
                break;

            case RIGHT:
                x += 200;
                break;

            case TO_LEFT:
                _speed -= .5;
                break;

            case TO_RIGTH:
                _speed += .5;
                break;
        }

        if (value == TO_LEFT || value == TO_RIGTH)
        {
            _box.x += _speed;
        }
        else
        {
            removeEventListener(Event.ENTER_FRAME, onEnterFrame);
            _moving = true;
            TweenLite.to(_box, .5, {x: x, y: y});
        }
    }
}
}
