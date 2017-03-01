package {

import flash.display.Sprite;
import flash.geom.Rectangle;

import starling.core.Starling;
import starling.events.Event;

[SWF(width="800", height="450", frameRate="60", backgroundColor="#808080")]

public class Main extends Sprite {

    private var _starling:Starling;

    public function Main() {

        var width:int = stage.fullScreenWidth;
        var height:int = stage.fullScreenHeight;

        _starling = new Starling(Game, stage, new Rectangle(0,0, width, height));
        _starling.stage.stageWidth = width;
        _starling.stage.stageHeight = height;
        _starling.showStats = true;
        _starling.start();

        _starling.addEventListener(Event.ROOT_CREATED, onRootCreated);
    }

    private function onRootCreated(event:Event, root:Game):void
    {
        root.start();
    }

}
}
