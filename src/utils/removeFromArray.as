/**
 * Created by SalmanPC3 on 3/12/2017.
 */
package utils
{
    //remove an Item from an Array
    public function removeFromArray(list:Array, item:Object)
    {
        var length:int = list.length
        for (var i: int = 0; i < length; i++)
        {
            if (list[i] == item)
            {
                list.splice(i, 1);
                return;
            }
        }
    }
}
