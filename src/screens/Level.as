/**
 * Created by SalmanPC3 on 3/3/2017.
 */
package screens
{
import flash.geom.Point;
import flash.geom.Rectangle;

import starling.animation.IAnimatable;

import starling.animation.Tween;

import starling.display.Sprite;
import starling.utils.Pool;

public class Level extends Sprite
{
    private var _plane:Plane;
    private var _planes:Array;
    public function Level()
    {
        _planes = new Array();
        var startX:int = Config.PLANE_WIDTH / 2;

        for (var i:int = 0; i<Config.PLANE_NUMBER; i++)
        {
            _plane = new Plane();
            _plane.x = startX + i * Config.PLANE_DISTANCE;
            _planes.push(_plane)
            addChild(_plane);

            var random:Number = Math.random()

            if(random > .5)
                    addTween(_plane,random);
            else
                    _plane.visible = false;
        }
    }

    private function addTween(plane:Plane, random:Number):void
    {
        return
        var x:int = plane.x;
        if(random > .75)
            x +=  plane.width;
        else
            x -=  plane.width;

        var t:Tween = new Tween(plane, 3);
        t.animate('x', x);
        t.repeatCount = 0;
        t.reverse = true;
        GameArea.juggler.add(t);
    }


    public function colision(object:Sprite):Object
    {

        for (var i:int = 0; i<Config.PLANE_NUMBER; i++)
        {
            _plane = _planes[i];
            if(!_plane.visible)
                    continue;

            var rect1:Rectangle = object.getBounds(stage);
            var rect2:Rectangle = _plane.getBounds(stage);

            var collide:Boolean = rect1.intersects(rect2);

            if(collide
                    && rect1.y + rect1.height <= rect2.y + rect2.height/2
                    && rect1.x + rect1.width/2 <= rect2.x + rect2.width
                    && rect1.x + rect1.width/2 >= rect2.x )
            {
                var p:Point = Pool.getPoint(0 , rect2.y);
                var y:int = object.globalToLocal(p).y;
                Pool.putPoint(p);

                return {plane:_planes[i],y:y};
            }

        }
        return null;
    }

}
}
