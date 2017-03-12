/**
 * Created by SalmanPC3 on 3/3/2017.
 */
package screens
{

import Physics.Platform;
import Physics.PlatformSorter;

import objects.Hero;

import starling.animation.Juggler;
import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;

import Physics.PhysicsHandler;

import starling.text.TextField;

import utils.TouchHandler;

public class GameArea extends Sprite
{
    private var touchHandler:TouchHandler;
    private var physic:PhysicsHandler;
    public static var _hero:Hero;
    public static var juggler:Juggler = new Juggler();
    private var _index:int;
    private var _lastY:int;
    private var _level:TextField;

    private var platSort:PlatformSorter;


    public function GameArea()
    {
        addEventListener(Event.ADDED_TO_STAGE, onAdd)
    }

    private function onAdd(event:Event):void
    {
        removeEventListener(Event.ADDED_TO_STAGE, onAdd);

        _level = new TextField(100,20);
        _level.y = Config.STAGE_HEGHT - _level.height;
        parent.addChild(_level)


        platSort = new PlatformSorter(SortPlatforms);

        touchHandler = new TouchHandler(parent, touch);

        physic = new PhysicsHandler();

        var heroGraphic:HeroGraphic = new HeroGraphic();
        _hero = new Hero(physic.hero, heroGraphic);
        _hero.y = Config.STAGE_HEGHT - 100;
        addChild(_hero.graphic);

        platSort.setLevel();
        platSort.setLevel();
        platSort.setLevel();
        platSort.setLevel();

    }

    private function SortPlatforms(list:Array, level:int)
    {
        _level.text = 'level: ' + String(level-4);
        level = Config.STAGE_HEGHT - level * (Config.STAGE_HEGHT/4);
        for(var i:int=0; i<list.length ; i++)
        {
            floor(37+list[i].index*96,level)
        }
    }




    private function floor(x:int, y:int):void
    {
        _lastY = y;
        var platform:Platform = physic.addFloor(x, y, Config.PLATFORM_WIDTH, 1, Config.PLATFORM, platformHandler);
        addChildAt(platform.graphic,0);
    }

    public function touch(dir:String):void
    {
       _hero.move(dir);
    }

    public function get X():int
    {
        var random:Number = Math.random();

        if(random < .33)
            _index--
        else if (random > .66)
            _index++;

        if(_index < 0)
            _index = 0;
        else if(_index > Config.PLATFORM_NUMS)
            _index = Config.PLATFORM_NUMS;

        var x:int = Config.PLATFORM_MARGIN  + (_index/1) * (Config.PLATFORM_WIDTH + Config.PLATFORM_DISTANCE);
        return x;
    }

    public function advanceTime(time:Number):void
    {
        juggler.advanceTime(time);
        physic.advanceTime(time);
        moveArea();

    }

    function moveArea()
    {
        if(_hero.jumping)
        {
            _hero.speedY = 0;

        }

        if(_hero.y + y < Config.STAGE_HEGHT/2.5)
        {
            var dis:Number = y - (Config.STAGE_HEGHT/2.5 - _hero.y)
            if(_hero.jumping && _hero.jumps < 150)
            {
                y -= dis;
            }
            else if(dis > -1)
                y -= dis;
            else
                y -= dis/10;

            if (_lastY + y > Config.STAGE_HEGHT/5)
                platSort.setLevel();
        }
        else if(_hero.y + y > Config.STAGE_HEGHT)
        {
            _hero.y = Config.STAGE_HEGHT/2 - y;
            _hero.x = Config.STAGE_WIDTH/2 - x;
        }
    }

    private function platformHandler(body:Platform):void
    {
        if (body.y + y > Config.STAGE_HEGHT *1)
        {
            body.dispose();
            physic.remove(body);
        }
    }
}
}
