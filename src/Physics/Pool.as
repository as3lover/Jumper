/**
 * Created by mkh on 2017/03/11.
 */
package Physics
{
public class Pool
{
    private static var _platformLength:int = 0;
    private static const _platforms:Array = new Array();

    public static function setPlatform(body:Platform):void
    {
        body.space = null;
        _platformLength++;
        _platforms.push(body);
    }

    public static function getPlatform():Platform
    {
        if(_platformLength)
        {
            _platformLength--;
            return _platforms.pop();
        }
        else
            return null
    }
}
}
