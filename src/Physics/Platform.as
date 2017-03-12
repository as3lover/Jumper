/**
 * Created by mkh on 2017/03/11.
 */
package Physics
{
import nape.callbacks.CbType;
import nape.phys.BodyType;
import nape.space.Space;
import nape.shape.Polygon

public class Platform extends PhysicObject
{
    private var _direction:String;
    public var originalSpace:Space;

    private static var _length:int;

    public function Platform(x:int, y:int, width:int, height:int, space:Space ,bodyType:BodyType, cbType:CbType = null)
    {
        super(bodyType);
        shape = new Polygon(Polygon.rect(5,0,width-10,height));
        this.x = x;
        this.y = y;
        this.cbTypes = cbType;
        this.space = space;
        originalSpace = space;

        _length++;
    }

    public function get direction():String
    {
        return _direction;
    }

    public function set direction(value:String):void
    {
        _direction = value;
    }

    public function dispose():void
    {
        graphic.dispose();
        Pool.setPlatform(this);
    }
}
}
