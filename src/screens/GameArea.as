/**
 * Created by SalmanPC3 on 3/3/2017.
 */
package screens
{
import objects.Hero;

import starling.animation.Juggler;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.KeyboardEvent;

public class GameArea extends Sprite
{
    private var _hero:Hero;
    private var _levels:LevelHolder;
    private var _xDistance:int;
    private var _yDistance:int;
    public static var juggler:Juggler = new Juggler();


    public function GameArea()
    {
        _levels = new LevelHolder();
        addChild(_levels);

        _hero = new Hero();
        _hero.x = 200;
        _hero.y = 250;
        addChild(_hero);

        addEventListener(Event.ADDED_TO_STAGE, onAdd)
    }

    private function onAdd(event:Event):void
    {
        removeEventListener(Event.ADDED_TO_STAGE, onAdd);
        stage.addEventListener(KeyboardEvent.KEY_DOWN, key);
    }

    private function key(e:KeyboardEvent):void
    {
        trace(e.keyCode);
        switch(e.keyCode)
        {
            case 39:
                _hero.move(Config.RIGHT_UP);
                break;

            case 37:
                _hero.move(Config.LEFT_UP)
                break;

            case 38:
                _hero.move(Config.UP)
                break;
        }
    }

    public function advanceTime(time:Number):void
    {
        var obj:Object;
        if(_hero.moving)
        {
            if(_hero.direction == Config.DOWNWARD)
            {
                obj = _levels.cllision(_hero)
                if(obj)
                {
                    _hero.moving = false;
                    _hero.chain = obj.plane;
                    //_hero.y = obj.y;

                     _xDistance = _hero.x - _hero.chain.x;
                    _yDistance = _hero.y - _hero.chain.y;
                }
            }
        }
        else if(_hero.chain)
        {
            _hero.x = _xDistance + _hero.chain.x;
            _hero.y = _yDistance + _hero.chain.y;
        }

        juggler.advanceTime(time);
    }
}
}
