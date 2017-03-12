/**
 * Created by SalmanPC3 on 3/12/2017.
 */
package Physics
{

import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.space.Space;

import screens.HeroGraphic;

import starling.display.Sprite;

public class Hero extends PhysicObject
{
    private var _parent:Sprite;
    public const JUMPING_LEVELS:int = 220;
    private var _jumpingLevel:int;

    private const JUMPING:String = 'jumping';
    private const FINISH_JUMP:String = 'finish jump';
    private const BALLOON:String = 'ballon';
    private const NORMAL:String = 'normal';

    public const STATUS:Object = {NORMAL:'normal', JUMPING:'jumping', BALLOON:'ballon'};

    public function Hero(space:Space, parent:Sprite)
    {
        super(BodyType.DYNAMIC);

        var width:int = Config.HERO_WIDTH;
        var height:int = Config.HERO_HEIGTH;

        shape = new Polygon(Polygon.rect(width/10,height/10,width*.8,height*.8));
        body.allowRotation = false;
        shape.material.rollingFriction = 0;
        this.space = space;
        graphic = new HeroGraphic();
        type = Config.HERO_TYPE
        status = NORMAL;
        collide = collideFunction;

        this.parent = parent;
    }

    // Parent Display Object =======================
    public function set parent(parent:Sprite)
    {
        _parent = parent;
        parent.addChild(graphic)
    }

    public function get parent():Sprite
    {
        return _parent;
    }

    // Update on Advance time =======================
    public override function update():void
    {
        switch(status)
        {
            case JUMPING:
                jumping();
                break;

            case BALLOON:
                flyingDown();
                break;
        }

        super.update();

    }

    //================
    public function get isJumping():Boolean
    {
        if(status == STATUS.JUMPING)
                return true;
        else
                return false
    }

    private function flyingDown():void
    {
        if(speedY < - Config.SLOW_Y_SPEED)
            super.speedY = -Config.SLOW_Y_SPEED;

        if(speedX < -Config.SLOW_X_SPEED)
            super.speedX = -Config.SLOW_X_SPEED;
        else if(speedX > Config.SLOW_X_SPEED)
            super.speedX = Config.SLOW_X_SPEED;
    }

    public override function set speedY (speed:Number):void
    {
        if(status == NORMAL)
            super.speedY = speed;
    }

    // STATUS ===============
    public override function set status(value:String):void
    {
        switch (value)
        {
            case NORMAL:
                setNormal();
                break;

            case JUMPING:
                setJump();
                break;

            case BALLOON:
                setBalloon();
                break;
        }

        super.status = value;
    }

    private function setJump():void
    {
        _jumpingLevel = JUMPING_LEVELS;
        graphic.jumping();
    }

    private function setNormal():void
    {
        graphic.normal();
    }

    private function setBalloon():void
    {
        graphic.ballon();
    }



    private function jumping():void
    {
        speedX = 0;

        _jumpingLevel--;

        // change graphic scaleY
        //pressing
        if(_jumpingLevel > JUMPING_LEVELS-30)
        {
            graphic.ScaleY *= .99;
            graphic.ScaleX = 1 + (1 - graphic.ScaleY);
            return
        }

        //stretching
        var scale:Number = 1 + (_jumpingLevel/(JUMPING_LEVELS-30)) * .2;
        var dis = graphic.ScaleY - scale;
        if(dis)
        {
            graphic.ScaleY -= dis/2
            graphic.ScaleX = 1 + (1 - graphic.ScaleY);
        }

        if(_jumpingLevel == 100)
            graphic.reverseChiling();


        /*
        //stretching
        else if(_jumpingLevel > 100 &&  graphic.ScaleY<1.2)
        {
            graphic.ScaleY *= 1.05;
            graphic.ScaleX = 1 + (1 - graphic.ScaleY);
        }
        //to normal size
        else if(_jumpingLevel < 50 && graphic.ScaleY > 1)
        {
            graphic.ScaleY *= .999;
            if(graphic.ScaleY <1)
                    graphic.ScaleY = 1;

            graphic.ScaleX = 1 + (1 - graphic.ScaleY);
        }
        */

        //High speed to down
        super.speedY = Config.HERO_JUMPING_SPEED * (_jumpingLevel/(JUMPING_LEVELS-30));

        //shaking game area
        parent.parent.x = (-0.5 + Math.random()) * _jumpingLevel/20;
        parent.parent.y = (-0.5 + Math.random()) * _jumpingLevel/20;

        //finish jumping
        if(_jumpingLevel < 1)
        {
            parent.parent.x = parent.parent.y = 0;
            graphic.ScaleY = graphic.ScaleX = 1;
            status = STATUS.BALLOON;
        }

    }



    public function collideFunction():void
    {
        switch (status)
        {
            case NORMAL:
                break;

            case JUMPING:
                break;

            case BALLOON:
                    status = STATUS.NORMAL;
                break;

        }
    }


    public function move(dir:String):void
    {
        if(status == STATUS.BALLOON || status == STATUS.JUMPING)
        {
            if(dir == Config.TO_LEFT || dir == Config.LEFT || dir == Config.LEFT_UP)
            {
                speedX = - Config.HERO_X_SPEED_JUMPING;
            }
            else if(dir == Config.TO_RIGTH || dir == Config.RIGHT || dir == Config.RIGHT_UP)
            {
                speedX = Config.HERO_X_SPEED_JUMPING;
            }
            return;
        }
        switch (dir)
        {
            case Config.UP:
                //speedX = 100;
                speedY = Config.HERO_UP_Y_SPEED;
                break;

            case Config.LEFT:
                speedX = Config.HERO_LEFT_X_SPEED;
                speedY = Config.HERO_LEFT_Y_SPEED;
                break;

            case Config.RIGHT:
                speedX = Config.HERO_RIGHT_X_SPEED;
                speedY = Config.HERO_RIGHT_Y_SPEED;
                break;

            case Config.LEFT_UP:
                speedX = Config.HERO_LEFT_UP_X_SPEED;
                speedY = Config.HERO_LEFT_UP_Y_SPEED;
                break;

            case Config.RIGHT_UP:
                speedX = Config.HERO_RIGHT_UP_X_SPEED;
                speedY = Config.HERO_RIGHT_UP_Y_SPEED;
                break;

            case Config.TO_LEFT:
                speedX = Config.HERO_TO_LEFT_X_SPEED
                break;

            case Config.TO_RIGTH:
                speedX = Config.HERO_TO_RIGHT_X_SPEED;
                break;


        }
    }

    public function get jumps():int
    {
        return _jumpingLevel;
    }

}
}
