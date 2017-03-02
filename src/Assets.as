/**
 * Created by SalmanPC3 on 3/1/2017.
 */
package
{
import flash.system.System;
import starling.events.Event;
import starling.textures.Texture;
import starling.utils.AssetManager;
import starling.events.EventDispatcher;

public class Assets extends EventDispatcher
{
    private var _asset:AssetManager;

    public function Assets()
    {
        _asset = new AssetManager();
        //_asset.scaleFactor = 10;
        _asset.enqueue(EmpeddedAssets);

        _asset.loadQueue(function(ratio:Number):void
        {
            trace("Loding " + String(ratio) + " %");
            if (ratio == 1)
            {
                // now would be a good time for a clean-up
                System.pauseForGCIfCollectionImminent(0);
                System.gc();

                dispatchEventWith(Event.COMPLETE);
            }
        });

    }

    public function getTexture(name:String):Texture
    {
        return _asset.getTexture(name);
    }
}
}
