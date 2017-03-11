/**
 * Created by mkh on 2017/03/11.
 */
package objects
{
import com.greensock.TweenLite;

import screens.GameArea;

import starling.core.Starling;

import starling.display.Image;

import starling.display.Sprite;
import starling.extensions.PDParticleSystem;

public class PlatformGraphic extends Sprite
{
    private var _chili:Image;
    private var type:String;
    private const NORMAL:String = 'normal';
    private const CHILI:String = 'chili';

    public function PlatformGraphic()
    {
        addChild(Game.getImage('platform'));
        reset();
    }

    public function reset()
    {
        visible = true;
        type = NORMAL;
        if (Math.random() > .9)
        {
            addChild(chili);
            type = CHILI;
        }

    }

    public override function dispose():void
    {
        visible = false;
        removeFromParent();
        while(numChildren > 1)
        {
            this.removeChildAt(1);
        }
    }

    public function collid():void
    {
        if(type == CHILI)
        {
            Hero.chili();
            _chili.removeFromParent();

            var ps:PDParticleSystem = Game.assets.getParticle('chili');
            ps.x = GameArea._hero.x + Config.HERO_RADIUS;
            ps.y = GameArea._hero.y + Config.HERO_RADIUS*2;
            GameArea._hero.graphic.parent.addChild(ps);
            GameArea._hero.graphic.parent.setChildIndex(GameArea._hero.graphic ,GameArea._hero.graphic.parent.numChildren-1)
            Starling.juggler.add(ps);
            ps.start(.7);
        }
    }

    private function get chili():Image
    {
        if(!_chili)
        {
            _chili = Game.getImage('chili');
            _chili.x = Config.PLATFORM_WIDTH / 2 - _chili.width/2;
            _chili.y =  - _chili.height;
        }

        return _chili;
    }
}
}
