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

import starling.display.Sprite;

import starling.utils.deg2rad;
import starling.utils.rad2deg;

import utils.removeFromArray;

public class PhysicObject extends Object
{
    private var _body:Body;
    private var _shape:Shape;
    private var _graphic:Sprite;
    private var _updateList:int;
    private var _onUpdateFunctions:Array;

    public function PhysicObject(bodyType:BodyType)
    {
        _body = new Body(bodyType);
        _onUpdateFunctions = new Array()
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
    private function updateGraphic():void
    {
        if(_graphic)
        {
            _graphic.x = x;
            _graphic.y = y;
            _graphic.rotation = rotation;
        }
    }

    // Update on advance time =====================
    public function update():void
    {
        updateGraphic();
        for(var i:int=0; i<_updateList; i++)
        {
            _onUpdateFunctions[i](this);
        }
    }

    public function addUpdateFunction(updateFunction:Function):void
    {
        _onUpdateFunctions.push(updateFunction);
        _updateList++;
    }

    public function removeUpdateFunction(updateFunction:Function):void
    {
        removeFromArray(_onUpdateFunctions, updateFunction);
        _updateList--;
    }

    // Name ===================================
    public function get name():String
    {
        return _body.userData.name;
    }

    public function set name(value:String):void
    {
        _body.userData.name = value;
    }

    // Type ===================================
    public function get type():String
    {
        return _body.userData.type;
}

    public function set type(value:String):void
    {
        _body.userData.type = value;
    }
    //===== status
    public function get status():String
    {
        return _body.userData.status;
    }
    public function set status(value:String):void
    {
        _body.userData.status = value;
    }
        //=====
    public function get collide():Function
    {
        return _body.userData.collide;
    }
    public function set collide(value:Function):void
    {
        _body.userData.collide = value;
    }
    // Handler Function ===================================
    public function set handler(value:String):void
    {
        _body.userData.status = value;
    }
}
}

