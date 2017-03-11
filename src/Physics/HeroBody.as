/**
 * Created by mkh on 2017/03/11.
 */
package Physics
{
import nape.geom.Vec2;
import nape.phys.BodyType;
import nape.shape.Circle;
import nape.shape.Polygon;
import nape.space.Space;


public class HeroBody extends PhysicObject
{

    public function HeroBody(space:Space)
    {
        var dim:int = Config.HERO_RADIUS*2;
        super(BodyType.DYNAMIC);
        //shape = new Circle(Config.HERO_RADIUS, new Vec2(Config.HERO_RADIUS, Config.HERO_RADIUS));
        shape = new Polygon(Polygon.rect(dim/10,dim/10,dim*.8,dim*.8));
        body.allowRotation = false;
        this.space = space;
        //shape.material.dynamicFriction = 2;
        shape.material.rollingFriction =0;
    }

}
}
