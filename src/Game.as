/**
 * Created by SalmanPC3 on 3/1/2017.
 */
package
{
import flash.utils.setTimeout;

import screens.GameArea;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;


public class Game extends Sprite
{
    public static var assets:Assets;
    private var _background:Image;
    private var _gameArea:GameArea;
    public function Game()
    {

    }

    public function start():void
    {
        assets = new Assets();
        assets.addEventListener(Event.COMPLETE, onComplete);
    }

    private function onComplete(event:Event):void
    {
        _background = new Image(assets.getTexture("background"));
        addChild(_background);

        _gameArea = new GameArea();
        addChild(_gameArea);

        setTimeout(startGame,300)
        function startGame(){addEventListener(Event.ENTER_FRAME, advanceTime);}
    }

    private function advanceTime(event:Event, passedTime:Number):void
    {
        _gameArea.advanceTime(passedTime);
    }
}
}
