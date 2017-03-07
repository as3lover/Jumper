/**
 * Created by SalmanPC3 on 3/7/2017.
 */
package objects
{
public interface IMovable
{
    speedX:Number;
    speedY:Number;
    direction:int;
    density:Number;
    chain:Object;
    chained:Boolean;
    walking:Boolean;
    jumping:Boolean;
    distanceX:Number;
    distanceY:Number;
    vFactor:Number ;
    startWalkSpeed:Number ;
}
}
