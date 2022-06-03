import java.util.ArrayList;
import java.lang.Math.*;
float playerSize = 50;
float playerX = 1 +playerSize/-2;
float playerY = 1 +playerSize/-2;
float velocityX = 0;
float velocityY =0;
float relativeMouseX = 0;
float relativeMouseY = 0;
float originalX = 0;
float originalY = 0;
int playerHealth = 3;
boolean mouseHeld = false;
boolean setVelocity = true;
ArrayList<slingshot> slingList = new ArrayList<slingshot>();
ArrayList<rectangle> rectList = new ArrayList<rectangle>();
int screenSize = 1400;
int stage = 1;
boolean didPhase = false;
int currentLineAttached = 0; //0 is for no line, 1 is for first line in singList, 2 for 2nd, etc
void setup(){
  frameRate(60);
  background(0,0,0);
  slingList.add(new slingshot(0.0,300.0));
  slingList.add(new slingshot(0.0,300.0));
  currentLineAttached = 1;
}
public void settings(){
  size(1400,1400);
}
void draw(){
  translate(screenSize/2,screenSize/2);
  background(0,0,0);
  coreLoop();  
}
void levelDetect(){
  if(stage == 1 ){
    stage1();
  }
}
void stage1(){
  if(!didPhase){
    didPhase = true;
    rectList.add(new rectangle(screenSize+ 400, -500, screenSize+500, 400));
    rectList.get(0).setXVelocity(-50.0);
  }
}
void coreLoop(){
  levelDetect();
  displayRectangle();
  if(playerHealth > 0){
    keyInputs();
    playerDisplay();
    healthDisplay();
  }
  else{
    textSize(60);
    fill(0,200,0);
    text("You Lose!, try again by pressing t",-300,0);
  }
  displaySlingshot();

  detectContact();
}
void playerDisplay(){
  stroke(0,0,0);
  playerX += velocityX;
  playerY +=velocityY;
  if(playerX+playerSize> screenSize/2){
    playerX = screenSize/2 - playerSize;
    velocityX = 0;
  }
  if(playerY+playerSize> screenSize/2){
    playerY = screenSize/2 - playerSize;
    velocityY = 0;
  }
  if(playerX< -1*screenSize/2){
    playerX = -1*screenSize/2;
    velocityX = 0;
  }
  if(playerY< -1*screenSize/2){
    playerY = -1*screenSize/2;
    velocityY = 0;
  }
  fill(133,23,43);
  rect(playerX,playerY,playerSize,playerSize);
}
void healthDisplay(){
  for(int x = 0; x < playerHealth;x++){
    fill(0,100,100);
    rect((200*x)-100,screenSize/2-200,100,200);
  }
}
void keyInputs(){
  if(mousePressed){
      if(!mouseHeld){
        relativeMouseX = mouseX;
        relativeMouseY = mouseY;
        originalX = playerX;
        originalY = playerY;
        velocityX = 0;
        velocityY = 0;
        mouseHeld = true;
        setVelocity = false;
      }
      else{
        currentLineAttached = 1;
        playerX = originalX + (mouseX -relativeMouseX);
        playerY = originalY + (mouseY - relativeMouseY);
      }
  }
  else{
    mouseHeld = false;
      if(!setVelocity){
          setVelocity = true;
          velocityX = 2*(float)(Math.abs(sin(slingList.get(currentLineAttached-1).getRadians(playerX+playerSize/2,playerY+playerSize/2)))*Math.sqrt(slingList.get(currentLineAttached-1).getDistance(playerX+playerSize/2,playerY+playerSize/2)));
          velocityY = 2*(float)(Math.abs(cos(slingList.get(currentLineAttached-1).getRadians(playerX+playerSize/2,playerY+playerSize/2)))*Math.sqrt(slingList.get(currentLineAttached-1).getDistance(playerX+playerSize/2,playerY+playerSize/2)));
          if( playerX + playerSize/2 - slingList.get(currentLineAttached-1).xLocation > 0){
            velocityX *= -1;
          }
          if( playerY + playerSize/2 - slingList.get(currentLineAttached-1).yLocation > 0){
            velocityY *= -1;
          }
          currentLineAttached = 0;
        }
  }
}
void displaySlingshot(){
  for(int x = 0; x < slingList.size();x++){
    stroke(0,0,0);
    fill(200,200,0);
    circle(slingList.get(x).xLocation,slingList.get(x).yLocation,30);
  }
   attachSling();
}
void attachSling(){
  if(currentLineAttached > 0){
    stroke(200,200,0);
    fill(200,200,0);
    line(playerX+playerSize/2,playerY+playerSize/2,slingList.get(currentLineAttached-1).xLocation,slingList.get(currentLineAttached-1).yLocation);
  }
}
void displayRectangle(){
  for(int x = 0; x < rectList.size();x++){
    rectList.get(x).frameAction();
    rect(rectList.get(x).x1,rectList.get(x).y1,rectList.get(x).x2 - rectList.get(x).x1,rectList.get(x).y2 - rectList.get(x).y1);
  }
}
void detectContact(){
   for(int x = 0; x < rectList.size();x++){
      if(rectList.get(x).detectContactBounds(playerX,playerY,playerX + playerSize, playerY + playerSize)){
         System.out.println("you got hit");
      }
  }
}
