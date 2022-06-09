import java.util.ArrayList;
import java.lang.Math.*;
float playerSize = 50;
float playerX = 1 +playerSize/-2;
float playerY = 600 +playerSize/-2;
float velocityX = 0;
float velocityY =0;
float relativeMouseX = 0;
float relativeMouseY = 0;
float originalX = 0;
float originalY = 0;
int playerHealth = 4;
boolean mouseHeld = false;
boolean setVelocity = true;
ArrayList<slingshot> slingList = new ArrayList<slingshot>();
ArrayList<rectangle> rectList = new ArrayList<rectangle>();
int screenSize = 1400;
int hitFrames = 0;
int stage = 1;
int phase = 0;
boolean didPhase = false;
int currentLineAttached = 0; //0 is for no line, 1 is for first line in slingList, 2 for 2nd, etc
void setup(){
  frameRate(60);
  background(0,0,0);
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
  fill(128);
  rect(-1* screenSize/2,-250,screenSize,500);
  if(!didPhase){
    if(phase == 0){
      slingList.add(new slingshot(0.0,320.0));
      slingList.add(new slingshot(0.0, -320.0));
      rectList.add(new rectangle(screenSize+ 400, 200, screenSize+700, 700, 000256000));
      rectList.add(new rectangle(screenSize+1700, -1*screenSize, screenSize+2000, -100, 000256000));
    }
    else if(phase == 1){
      rectList.add(new rectangle(screenSize+ 400, 290, screenSize+700, screenSize, 000256000));
      rectList.add(new rectangle(screenSize+400, -1*screenSize, screenSize+700, -290, 000256000));
    }
      else if(phase == 2){
        rectList.add(new rectangle(screenSize/2,-1*screenSize/2,screenSize+300+ 7000,100,000256000));
      for(int x = 0; x < 10; x++){
        rectList.add(new rectangle(screenSize+ 700*x, 200+200  * (x%2), screenSize+300+ 700*x, 400 + (screenSize/2-400) *(x %2), 000256000));
     }
     rectList.add(new rectangle(screenSize+ 8000, 200, screenSize+8200, screenSize/2 , 000256000));
   }
   didPhase = true;
 }
}
boolean slingCutoff(){
   if(stage == 1 ){
    return cutoff1();
  }
  return false;
}
boolean cutoff1(){
    if(playerY > 250 || playerY+playerSize < -250){
      return false;
    }
    return true;
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
    if(key == 't'){
      reset();
    }
  }
  displaySlingshot();

  detectContact();
}
void reset(){
  playerX = 1 +playerSize/-2;
  playerY = 600 +playerSize/-2;
  velocityX = 0;
  velocityY =0;
  relativeMouseX = 0;
  relativeMouseY = 0;
  originalX = 0;
  originalY = 0;
  playerHealth = 4;
  mouseHeld = false;
  setVelocity = true;
  slingList = new ArrayList<slingshot>();
  rectList = new ArrayList<rectangle>();
  screenSize = 1400;
  hitFrames = 0;
  stage = 1;
  phase = 0;
  didPhase = false;
  currentLineAttached = 0;
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
  if(hitFrames > 0){
    fill(0,23,133);
  }
  rect(playerX,playerY,playerSize,playerSize);
}
void healthDisplay(){
  fill(128);
  rect(screenSize/-2, screenSize/2-250,300,200);
  for(int x = 0; x < playerHealth;x++){  
    fill(0,200,0);
    rect((75*x)-screenSize/2+12,screenSize/2-225,50,150);
  }
}
void keyInputs(){
  if(mousePressed &&!slingCutoff()){
      if(!mouseHeld){
        relativeMouseX = mouseX;
        relativeMouseY = mouseY;
        originalX = playerX;
        originalY = playerY;
        velocityX = 0;
        velocityY = 0;
        mouseHeld = true;
        setVelocity = false;
        currentLineAttached = 1;
        for(int x = 0; x < slingList.size();x++){
          if(slingList.get(x).getDistance(playerX+playerSize/2,playerY+playerSize/2) <slingList.get(currentLineAttached-1).getDistance(playerX+playerSize/2,playerY+playerSize/2)){
          currentLineAttached = x+1;
          }
        }
      }
      else{
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
//handles getting  the closest sling aswell as attaching it
void attachSling(){
  if(currentLineAttached > 0){
    for(int x = 0; x < slingList.size();x++){
      if(slingList.get(x).getDistance(playerX+playerSize/2,playerY+playerSize/2) <slingList.get(currentLineAttached-1).getDistance(playerX+playerSize/2,playerY+playerSize/2)){
          currentLineAttached = x+1;
      }
    }
    stroke(200,200,0);
    fill(200,200,0);
    line(playerX+playerSize/2,playerY+playerSize/2,slingList.get(currentLineAttached-1).xLocation,slingList.get(currentLineAttached-1).yLocation);
  }
}
void displayRectangle(){
  for(int x = 0; x < rectList.size();x++){
    rectList.get(x).frameAction();
    fill(rectList.get(x).displayColor/1000000,(rectList.get(x).displayColor%1000000)/1000,rectList.get(x).displayColor%1000);
    rect(rectList.get(x).x1,rectList.get(x).y1,rectList.get(x).x2 - rectList.get(x).x1,rectList.get(x).y2 - rectList.get(x).y1);
    if((rectList.get(x).x2 < -2000 && rectList.get(x).getXVelocity() < 0)||(rectList.get(x).x2 > 2000 && rectList.get(x).getXVelocity() > 0)){
      rectList.remove(x);
      if(rectList.size() < 2){
        didPhase = false;
        phase++;
      }
    }  
  }
}
void detectContact(){
   for(int x = 0; x < rectList.size();x++){
      if(rectList.get(x).detectContactBounds(playerX,playerY,playerX + playerSize, playerY + playerSize)&& hitFrames == 0){
        hitFrames = 60;
        playerHealth--;
      }
  }
  if(hitFrames > 0){
    hitFrames--;
  }
}
