/**
 * Created by mkh on 2017/03/10.
 */
package Physics
{
import objects.PlatformGraphic;

import starling.display.DisplayObject;

import nape.callbacks.CbType;
import nape.callbacks.InteractionType;
import nape.callbacks.PreCallback;
import nape.callbacks.PreFlag;
import nape.callbacks.PreListener;
import nape.dynamics.CollisionArbiter;
import nape.geom.Vec2;
import nape.phys.BodyType;
import nape.space.Space;

public class PhysicsHandler
{
    private static var _space:Space;
    private var _gravity:Vec2 ;
    private var _oneWayType:CbType;
    private var _hero:Hero;
    private var _bodies:Array ;
    private var _length:int;

    public function PhysicsHandler()
    {
        _gravity = new Vec2(Config.GRAVITY_X, Config.GRAVITY_Y);
        _space = new Space(_gravity);
        _bodies = new Array();

        _oneWayType = new CbType();
        _space.listeners.add(new PreListener(
                InteractionType.COLLISION,
                _oneWayType,
                CbType.ANY_BODY,
                oneWayHandler,
                 0,
                true
        ));

    }

    public function addHero(hero:Hero)
    {
        _hero = hero;
        addBody(_hero);
    }

    private function addBody(body:PhysicObject):void
    {
        _bodies.push(body);
        _length++;
    }

    private function oneWayHandler(cb:PreCallback):PreFlag
    {
        var colArb:CollisionArbiter = cb.arbiter.collisionArbiter;

        if ((colArb.normal.y > 0) != cb.swapped) {
            return PreFlag.IGNORE;
        }
        else {
            cb.int1.userData.collide();
            cb.int2.userData.collide();
            return PreFlag.ACCEPT;
        }
    }

    public function get hero():Hero
    {
        return _hero;
    }

    public function addFloor(x:int, y:int, width:int, height:int, type:String, onUpdateFunction:Function = null):Platform
    {
        var platform:Platform = Pool.getPlatform();
        if(platform == null)
        {
            platform = new Platform(x, y, width, height, _space,BodyType.KINEMATIC, _oneWayType);
            platform.graphic = new PlatformGraphic();
            platform.type = type;
            platform.addUpdateFunction(onUpdateFunction);
            platform.collide = platform.graphic.collide;
        }
        else
        {
            platform.x = x;
            platform.y = y;
            platform.graphic.reset();
            platform.space = platform.originalSpace;
        }

        addBody(platform);


        return platform;
    }

    public function advanceTime(time:Number):void
    {
        time *= Config.SPEED_SCLAE;
        _space.step(time);

        for (var i:int = 0; i<_length; i++)
        {
            PhysicObject(_bodies[i]).update();
        }
    }


    public function get space():Space
    {
        return _space;
    }

    public function remove(body:Platform):void
    {
        removeItem(_bodies, body)
    }

    //remove Item from ASrray
    private function removeItem(list: Array, item: Object)
    {
        for (var i: int = 0; i < list.length; i++)
        {
            if (list[i] == item)
            {
                list.splice(i, 1);
                _length--;
                return;
            }
        }
    }
}
}
