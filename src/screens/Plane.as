/**
 * Created by SalmanPC3 on 3/3/2017.
 */
package screens
{

import com.greensock.TimelineMax;

import starling.display.Sprite;
import starling.display.Quad;

public class Plane extends Sprite
{

    public function Plane()
    {
        var quad:Quad = new Quad(Config.PLANE_WIDTH, Config.PLANE_HEIGTH, Math.random()*0xffffff);
        quad.x = - Config.PLANE_WIDTH / 2;
        //quad.y = - Config.PLANE_HEIGTH / 2;
        addChild(quad);
    }
}
}
