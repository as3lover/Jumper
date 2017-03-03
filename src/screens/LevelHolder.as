/**
 * Created by SalmanPC3 on 3/3/2017.
 */
package screens
{


import starling.display.Sprite;

public class LevelHolder extends Sprite
{
    private var _levels:Array;
    private var _level:Level;
    public function LevelHolder()
    {
        _levels = new Array()

        for(var i:int = 0; i<Config.NUM_OF_LEVELS; i++)
        {
            _level = new Level();
            if(i%2)
                _level.x = Config.LEVEL_START_X_1;
            else
                _level.x = Config.LEVEL_START_X_2;
            _level.y = i * (_level.height + Config.LEVEL_DISTANCE);
            _levels.push(_level);
            addChild(_level)
        }
    }

    public function cllision(object:Sprite):Object
    {
        for(var i:int = 0; i <Config.NUM_OF_LEVELS; i++)
        {
            var obj:Object = _levels[i].colision(object);
            if(obj)
                return obj;
        }
        return null;
    }
}
}
