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

import utils.Gravity;

public class GameArea extends Sprite
{
    private var _hero:Hero;
    private var _levels:LevelHolder;
    private var touchHandler:TouchHandler;
    public static var juggler:Juggler = new Juggler();


    public function GameArea()
    {
        _levels = new LevelHolder();
        addChild(_levels);

        _hero = new Hero();
        _hero.x = 200;
        _hero.y = 200;
        addChild(_hero);

        addEventListener(Event.ADDED_TO_STAGE, onAdd)
    }

    private function onAdd(event:Event):void
    {
        removeEventListener(Event.ADDED_TO_STAGE, onAdd);
        stage.addEventListener(KeyboardEvent.KEY_DOWN, key);
        touchHandler = new TouchHandler(parent, touch);
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

    public function touch(dir:String):void
    {
        _hero.move(dir);
    }

    public function advanceTime(time:Number):void
    {
        juggler.advanceTime(time);
        Gravity.advanceTime(time, _levels);
    }
}
}
