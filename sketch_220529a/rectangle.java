class rectangle{
    private float velocityX;
    private float velocityY;
    public float x1;
    public float y1;
    public float x2;
    public float y2;
    public int displayColor;
    public rectangle(float x1, float y1, float x2, float y2, int displayColor){
      this.x1 = x1;
      this.y1 = y1;
      this.x2 = x2;
      this.y2 = y2;
      this.displayColor = displayColor;
      this.velocityX = -15;
      if(this.x1 < 0){
         this.velocityX = 15;
      }
    }
    public void setXVelocity(float x){
      this.velocityX = x;
    }
     public void setYVelocity(float y){
      this.velocityY = y;
    }
     public void setVelocity(float x, float y){
      this.velocityX = x;
      this.velocityY = y;
    }
    public float getXVelocity(){
      return this.velocityX;  
    }
    public float getYVelocity(){
      return this.velocityY;
    }
    public void frameAction(){
      this.x1 += velocityX;
      this.x2 += velocityX;
      this.y1 += velocityY;
      this.y2 += velocityY;
    }
    public boolean dectectContactPoint(float x, float y){
      if(this.x1 <= x && x<= this.x2 && this.y1 <= y && y <= this.y2){
        return true;
      }
      return false;
    }
    public boolean detectContactBounds(float x1, float y1, float x2, float y2){
      if(dectectContactPoint(x1, y1)||dectectContactPoint(x1,y2)||dectectContactPoint(x2,y1)||dectectContactPoint(x2,y2)){
        return true;
      }
      return false;
    }
}
