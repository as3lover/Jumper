/**
 * Created by SalmanPC3 on 3/1/2017.
 */
package
{
import flash.system.System;

import starling.display.Image;

import starling.utils.AssetManager;

public class Assets
{
    private var _asset:AssetManager;

    public function Assets()
    {
        _asset = new AssetManager();
        _asset.enqueue(EmpeddedAssets);

        _asset.loadQueue(function(ratio:Number):void
        {
            trace("Loding " + String(ratio) + " %");
            if (ratio == 1)
            {
                // now would be a good time for a clean-up
                System.pauseForGCIfCollectionImminent(0);
                System.gc();

                onComplete();
            }
        });

    }

    private function onComplete():void
    {
        //addChild(new Image(_asset.getTexture("background")));
    }
}
}
