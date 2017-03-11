/**
 * Created by SalmanPC3 on 3/1/2017.
 */
package
{
import flash.system.System;
import flash.utils.setTimeout;

import starling.display.Image;
import starling.events.Event;
import starling.extensions.PDParticleSystem;
import starling.textures.Texture;
import starling.utils.AssetManager;
import starling.events.EventDispatcher;

public class Assets extends EventDispatcher
{
    private var _asset:AssetManager;
    private var _particles:Object;

    public function Assets()
    {
        _particles = new Object();
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

                setTimeout(onComplete,10);
                setTimeout(dispatchEventWith,15,Event.COMPLETE);
            }
        });

    }

    private function onComplete():void
    {
        var xml:XML = getXML('chiliParticle');
        var texture:Texture = getTexture('particleTexture');
        var ps:PDParticleSystem = new PDParticleSystem(xml, texture);
        _particles.chili = ps;
    }

    public function getTexture(name:String):Texture
    {
        trace('getTexture',name);
        return _asset.getTexture(name);
    }

    public function image(name:String):Image
    {
        trace('image',name);
        return new Image(getTexture(name));
    }

    public function getXML(name:String):XML
    {
        trace('getXML',name);
        return _asset.getXml(name);
    }

    public function getParticle(name:String):PDParticleSystem
    {
        trace('getParticle',name);
        trace(_particles.chili);
        return _particles[name];
    }
}
}
