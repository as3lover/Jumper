/**
 * Created by mkh on 2017/03/11.
 */
package Physics
{
public class PlatformSorter
{
    private var _plats:Array;

    private var RANDOM:int = 0;
    private var RIGHT:int = +1;
    private var LEFT:int = -1;
    private var _func:Function;

    public var level:int;


    public function PlatformSorter(func:Function)
    {
        _plats = [{index:3, direction:RANDOM}]
        _func = func;
        level = 0;
    }

    // تعیین سطوح فعال طبقه جدید
    public function setLevel():void
    {
        level++;

        //اگر دو سطح فعال بود
        if(_plats.length > 1)
        {
            // تعیین سطوح جدید
            _plats[0] = newIndex(_plats[0]);
            _plats[1] = newIndex(_plats[1]);
        }
        // ایجاد سطح دوم و تعیین مکان سطوح
        // بنا به تصادف
        else if (Math.random() > .9)
        {
            _plats[1] = {};
            _plats[1].index =   _plats[0].index + 1;
            _plats[1].direction = RIGHT;

            _plats[0].index =   _plats[0].index - 1;
            _plats[0].direction = LEFT;

            correctIndex(_plats[0]);
            correctIndex(_plats[1]);

        }
        // تعیین مکان سطح
        else
        {
            _plats[0] = newIndex(_plats[0]);
        }

        // اگر دوسطح یکسان بود سطح دوم غیر فعال شود
        if (_plats.length > 1 && _plats[0].index == _plats[1].index)
        {
            _plats[0].dir = RANDOM;
            _plats.pop();
        }

        _func(_plats,level);

    }

    private function newIndex(plat:Object):Object
    {
        if(plat.direction == RANDOM)
        {
            if(Math.random() > .5)
                plat.index++;
            else
                plat.index--;
        }
        else
        {
            plat.index += plat.direction;
            plat.direction = RANDOM;
        }

        correctIndex(plat);
        return plat;
    }

    private function correctIndex(plat:Object):void
    {
        if(plat.index < 0)
        {
            plat.index = 1;
            if(plat.direction == LEFT)
                plat.direction = RIGHT;
        }
        else if(plat.index > Config.PLATFORM_NUMS-1)
        {
            plat.index = Config.PLATFORM_NUMS - 2;
            if(plat.direction == RIGHT)
                plat.direction = LEFT;
        }
    }
}
}
