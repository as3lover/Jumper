package {

import flash.display.Sprite;
import flash.geom.Rectangle;

import starling.core.Starling;
import starling.events.Event;
import starling.utils.MathUtil;

[SWF(width="800", height="450", frameRate="60", backgroundColor="#808080")]

public class Main extends Sprite {

    private var _starling:Starling;
    private var _scale:Number;
    private var _offsetX:int;
    private var _offsetY:int;

    public function Main() {

        var fullWidth:int = stage.fullScreenWidth;
        var fullHeight:int = stage.fullScreenHeight;

        var width:int = 800;
        var height:int = 450;

        _starling = new Starling(Game, stage, new Rectangle(0,0, fullWidth, fullHeight));
        _starling.showStats = true;
        _starling.start();

        _starling.addEventListener(Event.ROOT_CREATED, onRootCreated);

        _scale = MathUtil.min(fullWidth/width , fullHeight/height);
       // _offsetX = fullWidth-width*_scale>
    }

    private function onRootCreated(event:Event, root:Game):void
    {
        root.scaleX = _scale;
        root.scaleY = _scale;
        root.x = _offsetX;
        root.y = _offsetY;
        root.start();
    }

}
}
