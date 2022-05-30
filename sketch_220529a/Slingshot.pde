import java.util.ArrayList;
import java.lang.Math.*;
float playerX = 0;
float playerY = 0;
float velocityX = 0;
float velocityY =0;
float playerSize = 50;
float relativeMouseX = 0;
float relativeMouseY = 0;
float originalX = 0;
float originalY = 0;
boolean mouseHeld = false;
boolean setVelocity = false;
ArrayList<slingshot> slingList = new ArrayList<slingshot>();
int screenSize = 1200;
int currentLineAttached = 0; //0 is for no line, 1 is for first line in singList, 2 for 2nd, etc
void setup(){
  frameRate(60);
  background(0,0,0);
  slingList.add(new slingshot(0.0,0.0));
  currentLineAttached = 1;
}
public void settings(){
  size(1200,1200);
}
void draw(){
  translate(screenSize/2,screenSize/2);
  background(0,0,0);
  coreLoop();  
}
void coreLoop(){
  keyInputs();
  playerDisplay();
  displaySlingshot();
}
void playerDisplay(){
  stroke(0,0,0);
  playerX += velocityX;
  playerY +=velocityY;
  fill(133,23,43);
  rect(playerX,playerY,playerSize,playerSize);
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
        playerX = originalX + (mouseX -relativeMouseX);
        playerY = originalY + (mouseY - relativeMouseY);
        if(!setVelocity){
          setVelocity = true;
          if(playerX -slingList.get(currentLineAttached-1).xLocation > 0){
            velocityX *= -1;
            velocityY += -1;
          }
        }
        System.out.println(slingList.get(currentLineAttached-1).getDegrees(playerX,playerY));
        attachSling();
      }
  }
  else{
    mouseHeld = false;
  }
}
void displaySlingshot(){
  for(int x = 0; x < slingList.size();x++){
    stroke(0,0,0);
    fill(200,200,0);
    circle(slingList.get(x).xLocation,slingList.get(x).yLocation,30);
  }
}
void attachSling(){
  if(currentLineAttached > 0){
    stroke(200,200,0);
    fill(200,200,0);
    line(playerX+playerSize/2,playerY+playerSize/2,slingList.get(currentLineAttached-1).xLocation,slingList.get(currentLineAttached-1).yLocation);
  }
}
