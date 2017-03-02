/**
 * Created by SalmanPC3 on 3/1/2017.
 */
package
{
import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;

public class Game extends Sprite
{
    public static var assets:Assets;
    private var _background:Image;
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
    }
}
}
