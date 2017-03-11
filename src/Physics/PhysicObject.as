/**
 * Created by mkh on 2017/03/11.
 */
package Physics
{
import nape.callbacks.CbType;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Shape;
import nape.space.Space;

import starling.display.DisplayObject;

import starling.utils.deg2rad;

import starling.utils.rad2deg;

public class PhysicObject extends Object
{
    private var _body:Body;
    private var _shape:Shape;
    private var _graphic:DisplayObject;
    private var _name:String;
    private var _type:String;
    private var _handler:Function;

    public function PhysicObject(bodyType:BodyType)
    {
        _body = new Body(bodyType);
    }

    public function set space(space:Space)
    {
        _body.space = space;
    }

    public function get body():Body
    {
        return _body;
    }

    // cbTypes =============================
    public function set cbTypes(cbType:CbType):void
    {
        if(cbType != null)
            _body.cbTypes.add(cbType);
    }
    // Shape =============================
    public function get shape():Shape
    {
        return _shape;
    }

    public function set shape(shape:Shape):void
    {
        _shape = shape;
        _shape.body = _body;
    }

    // Body X =============================
    public function get x():int
    {
        return _body.position.x;
    }

    public function set x(value:int):void
    {
        _body.position.x = value;
        updateGraphic();
    }

    // Body Y =============================
    public function get y():int
    {
        return _body.position.y;
    }

    public function set y(value:int):void
    {
        _body.position.y = value;
        updateGraphic();

    }

    // Speed X =============================
    public function get speedX():Number
    {
        return _body.velocity.x;
    }

    public function set speedX(value:Number):void
    {
        _body.velocity.x = value;
    }

    // Speed y =============================
    public function get speedY():Number
    {
        return - _body.velocity.y;
    }

    public function set speedY(value:Number):void
    {
        _body.velocity.y = - value;
    }

    // Rotation =============================
    public function get rotation():Number
    {
        return rad2deg(_body.rotation);
    }

    public function set rotation(value:Number):void
    {
        _body.rotation =  deg2rad(value);
        updateGraphic();
    }

    // Graphic =============================
    public function get graphic():*
    {
        return _graphic;
    }

    public function set graphic(displayObject):void
    {
        _graphic = displayObject;
        _body.userData.graphic = _graphic;
        updateGraphic();
    }

    // Update Graphic Position and Rotation ========
    public function updateGraphic():void
    {
        if(_graphic)
        {
            _graphic.x = x;
            _graphic.y = y;
            _graphic.rotation = rotation;
        }
    }

    // Name ===================================
    public function get name():String
    {
        return _name;
    }

    public function set name(value:String):void
    {
        _name = value;
    }

    // Type ===================================
    public function get type():String
    {
        return _type;
    }

    public function set type(value:String):void
    {
        _type = value;
    }
    // Handler Function ===================================
    public function get handler():Function
    {
        return _handler;
    }

    public function set handler(value:Function):void
    {
        _handler = value;
    }
}
}

