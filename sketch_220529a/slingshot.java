import java.lang.Math.*;
class slingshot{
    public float xLocation;
    public float yLocation;
    public slingshot(float xLocation, float yLocation){
       this.xLocation = xLocation;
       this.yLocation = yLocation;
    }
    public float getDistance(float x, float y){
       return (float)Math.sqrt((this.xLocation-x)*(this.xLocation-x)+(this.yLocation-y)*(this.yLocation-y));
    }
    public float getRadians(float x, float y){
      return (float)Math.atan((this.xLocation-x)/ (this.yLocation-y));
    }
}
