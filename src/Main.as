package {

import Physics.PhysicsHandler;

import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.utils.setTimeout;

import nape.util.BitmapDebug;
import nape.util.Debug;

import starling.core.Starling;
import starling.events.Event;
import starling.utils.MathUtil;

[SWF(width="800", height="450", frameRate="60", backgroundColor="#808080")]

public class Main extends Sprite {

    private var _starling:Starling;
    private var _scale:Number;
    private var _offsetX:int;
    private var _offsetY:int;
    private var _debug:Debug;

    public function Main() {

        var fullWidth:int = stage.fullScreenWidth;
        var fullHeight:int = stage.fullScreenHeight;

        var width:int = 800;
        var height:int = 450;

        _debug = new BitmapDebug(stage.stageWidth, stage.stageHeight, 0, true);


        _starling = new Starling(Game, stage, new Rectangle(0,0, fullWidth, fullHeight));
        _starling.showStats = true;
        _starling.start();

        _starling.addEventListener(starling.events.Event.ROOT_CREATED, onRootCreated);

        _scale = MathUtil.min(fullWidth/width , fullHeight/height);
       // _offsetX = fullWidth-width*_scale>
    }

    private function onRootCreated(event:starling.events.Event, root:Game):void
    {
        root.scaleX = _scale;
        root.scaleY = _scale;
        root.x = _offsetX;
        root.y = _offsetY;
        root.start();

        setTimeout(stage.addEventListener, 3000, flash.events.Event.ENTER_FRAME, ef);
        addChildAt(_debug.display,0);
    }

    private function ef(event:flash.events.Event):void
    {
       // _debug.clear();
       // _debug.draw(PhysicsHandler.space);
       // _debug.flush();
    }

}
}
