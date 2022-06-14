import java.util.ArrayList;
import java.lang.Math.*;
import processing.sound.*;
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
int textCooldown = 0;
boolean mouseHeld = false;
boolean setVelocity = true;
ArrayList<slingshot> slingList = new ArrayList<slingshot>();
ArrayList<rectangle> rectList = new ArrayList<rectangle>();
int screenSize = 1400;
int hitFrames = 0;
int stage = 0;
int phase = 0;
boolean didPhase = false;
int currentLineAttached = 0; //0 is for no line, 1 is for first line in slingList, 2 for 2nd, etc

SoundFile music;
boolean musicStarted = false;
void setup(){
  frameRate(60);
  background(0,0,0);
  music = new SoundFile(this,"audioFiles/startTutorial.wav");
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
  if(stage == 0){
    tutorial();
  }
  else if(stage == 1){
    levelSelect();
  }
  else if(stage == 2){
    stage1();
  }
}
void tutorial(){
  if(phase < 10 && !music.isPlaying()){
    music = new SoundFile(this,"audioFiles/startTutorial.wav");
    music.play();
  }
  else if(!music.isPlaying()){
    music = new SoundFile(this,"audioFiles/fullTutorial.wav");
    music.play();
    musicStarted = true;
  }
    if(phase == 0){
      fill(256,0,0);
      textSize(60);
      text("Oi! You there, you spidery blocky... thing.\nYou wanted to have some fun right?\n(Press Y to continue)",screenSize/-2+100,screenSize/-2+100);
  }
    else if(phase == 1){
      fill(256,0,0);
      textSize(60);
      text("Wait, you can't make webs can you?\n(Press Y to continue)",screenSize/-2+100,screenSize/-2+100);
    }
    else if(phase == 2){
      fill(256,0,0);
      textSize(60);
      text("Wait, you can't make webs can you?\n(Press Y to continue)",screenSize/-2+100,screenSize/-2+100);
    }
    else if(phase == 3){
      fill(256,0,0);
      textSize(60);
      text("Let me find something around here\n I have to have something in the junk\n(Press Y to continue)",screenSize/-2+100,screenSize/-2+100);
    }
    else if(phase == 4){
     fill(256,0,0);
     textSize(60);
     text("Here, I found this slingshot.\n Hold Left Click to sling on",screenSize/-2+100,screenSize/-2+100);
      if(!didPhase){
        slingList.add(new slingshot(0,0));
        didPhase = true;
      }
    }
    else if(phase == 5){
      fill(256,0,0);
      textSize(60);
      text("Keep holding it and move \n around a bit with the mouse",screenSize/-2+100,screenSize/-2+100);
    }
    else if(phase == 6){
      fill(256,0,0);
      textSize(60);
      text("Now let it go and let it rip!",screenSize/-2+100,screenSize/-2+100);
    }
    else if(phase == 7){
      fill(256,0,0);
      textSize(60);
      text("Well that does the trick!\n(Press Y to continue)",screenSize/-2+100,screenSize/-2+100);
    }
    else if(phase == 8){
      fill(256,0,0);
      textSize(60);
      text("Your health is in the bottom left.\n Dodge blocks and don't run out of bars.\n(Press S to continue)",screenSize/-2+100,screenSize/-2+100);
    }
    else if(phase == 9){
      fill(256,0,0);
      textSize(60);
      text("You ready?\n(Press Y to continue)",screenSize/-2+100,screenSize/-2+100);
      didPhase = false;
    }
    else if(phase == 10){
      if(!didPhase && musicStarted){
        rectList.add(new rectangle(screenSize+ 200, 200, screenSize+600, 700, 000256000));
        rectList.add(new rectangle(screenSize+ 900, -600, screenSize+1300, 200, 000256000));
        rectList.add(new rectangle(screenSize+ 1800, 0, screenSize+2200, 700, 000256000));
        rectList.add(new rectangle(screenSize+2700 , -1*screenSize, screenSize+3200,0, 000256000));
        rectList.add(new rectangle(screenSize+3200 , -300, screenSize+3600,300, 000256000));
        rectList.add(new rectangle(screenSize+4900 , 0 , screenSize+4300,screenSize/2, 000256000));
        didPhase = true;
      }
    }
    else if(phase == 11){
       if(!didPhase && musicStarted){
         rectList.add(new rectangle(screenSize/-2-500,screenSize/-2,screenSize/-2-200, 100,000256000));
         rectList.add(new rectangle(screenSize/2+200,-100,screenSize/2+500, screenSize/2,000256000));
         didPhase = true;
        }
    }
    else if(phase == 12){
     if(!didPhase && musicStarted){
         rectList.add(new rectangle(screenSize/-2-500,-100,screenSize/-2-200, screenSize/2,000256000));
         rectList.add(new rectangle(screenSize/2+200,screenSize/-2,screenSize/2+500,100,000256000));
         didPhase = true;
        }
    }
    else if(phase == 13){
     if(!didPhase && musicStarted){
       for(int x = 0; x < 7; x++){
         if(x % 2 == 0){
           rectList.add(new rectangle(screenSize/-2-3000-(x* 100),screenSize/-2-200-(x* 400),screenSize/-2+200-(x* 100), screenSize/-2-(x* 400),000256000));
           rectList.get(rectList.size()-1).setYVelocity(15);
           rectList.get(rectList.size()-1).setXVelocity(5);
           rectList.add(new rectangle(screenSize/-2+400-(x* 100),screenSize/-2-200-(x* 400),screenSize/2+3000-(x* 100), screenSize/-2-(x* 400),000256000));
           rectList.get(rectList.size()-1).setYVelocity(15);
           rectList.get(rectList.size()-1).setXVelocity(5);
           }
           else{
             rectList.add(new rectangle(screenSize/2-200+(x* 100),screenSize/-2-200-(x* 400),screenSize/2+3000+(x* 100), screenSize/-2-(x* 400),000256000));
             rectList.get(rectList.size()-1).setYVelocity(15);
             rectList.get(rectList.size()-1).setXVelocity(-5);
             rectList.add(new rectangle(screenSize/2-400+(x* 100),screenSize/-2-200-(x* 400),screenSize/-2-3000+(x* 100), screenSize/-2-(x* 400),000256000));
             rectList.get(rectList.size()-1).setYVelocity(15); 
             rectList.get(rectList.size()-1).setXVelocity(-5);
           }
         }
         didPhase = true;
        }
    }
    else if(phase == 14){
      fill(256,0,0);
      textSize(60);
      text("Looks like you're ready.\nSling yourself into that \n portal to start the game.",screenSize/-2+100,screenSize/-2+100);
      if(!didPhase){
        rectList.add(new rectangle(-75, 200, 75, 350, 256256256));
        rectList.get(0).setXVelocity(0);
      }
      didPhase = true;
    }
    if(textCooldown > 0){
      textCooldown--;
    }
}
void levelSelect(){
  if(!didPhase){
    didPhase = true;
    slingList.add(new slingshot(0,300));
    rectList.add(new rectangle(screenSize/-2+200, -75, screenSize/-2+350, 75, 256256256));
    rectList.get(rectList.size()-1).setXVelocity(0);
    rectList.add(new rectangle(screenSize/2-350, -75, screenSize/2-200, 75, 256256256));
    rectList.get(rectList.size()-1).setXVelocity(0);
  }
}
void stage1(){
  fill(128);
  rect(-1* screenSize/2,-250,screenSize,500);
  if(!didPhase){
    if(phase == 0){
      playerX = 1 +playerSize/-2;
      playerY = 600 +playerSize/-2;
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
       rectList.add(new rectangle(-1*screenSize- 8500, 200,-1* screenSize-8800, screenSize/2 , 000256000));
    }  
    else if(phase == 3){
        rectList.add(new rectangle(screenSize/-2,0,-1*(screenSize+300+ 7000),screenSize/2,000256000));
         
      for(int x = 0; x < 10; x++){
        rectList.add(new rectangle(-1* screenSize-300- 700*x, screenSize/-2 + 200  * (x%2),-1*screenSize- 700*x, screenSize/-2 + 200 * (x%2)+300, 000256000));
       }
       rectList.add(new rectangle(screenSize+ 8500, screenSize/-2, screenSize+8800,-200, 000256000));
    
   }
   else{
     reset();
   }
   didPhase = true;
   }
}
boolean slingCutoff(){
   if(stage == 0){
     return cutoffTutorial();
   }
   else if(stage == 2){
    return cutoff1();
  }
  return false;
}
boolean cutoffTutorial(){
    if(false){
      return true;
    }
    else{
      return false;
    }
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
  music.stop();
  if(stage > 0){
    stage = 1;
  }
  else{
    music = new SoundFile(this,"audioFiles/startTutorial.wav");
    music.play();
  }
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
  if(mousePressed &&!slingCutoff() && slingList.size() > 0){
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
    if((rectList.get(x).x2 < -1500 && rectList.get(x).getXVelocity() < 0)||(rectList.get(x).x2 > 1500 && rectList.get(x).getXVelocity() > 0)||(rectList.get(x).y2 < -1500 && rectList.get(x).getYVelocity() < 0)||(rectList.get(x).y2 > 1500 && rectList.get(x).getYVelocity() > 0)){
      rectList.remove(x);
      if(stage != 0 &&rectList.size() < 2){
        didPhase = false;
        phase++;
      }
    
    }  
  }
    if(stage == 0){
      if(phase < 4 || phase ==7 || phase == 9){
        if(key == 'y' && textCooldown == 0){
          didPhase = false;
          phase++;
          key = 'n';
          textCooldown = 40;
        }
      }
    else if(phase == 4){
      if(currentLineAttached == 1){
        didPhase = false;
        phase++;
        textCooldown = 40;
      }
    }
    else if(phase == 5){
      if(textCooldown == 0&&(mouseX -relativeMouseX > 200 ||mouseX -relativeMouseX < -200||mouseY -relativeMouseY > 200||mouseY -relativeMouseY < -200)){
        didPhase = false;
        phase++;
        key = 'n';
      }
    }
    else if(phase == 6){
       if(currentLineAttached == 0){
        didPhase = false;
        phase++;
        key = 'n';
        textCooldown = 40;
      }
    }
    else if(phase == 8){
        if(key == 's' && textCooldown == 0){
          didPhase = false;
          phase++;
          key = 'n';
          textCooldown = 40;

          
        }
    }
    else if(phase < 14){
        if(rectList.size() == 0&& didPhase){
          phase++;
          didPhase = false;
        }
    }
    else if(phase == 14){
        if(rectList.size()> 0 && rectList.get(0).detectContactBounds(playerX,playerY,playerX + playerSize, playerY + playerSize)){
          phase++;
      }
    }
    else{
      stage++;
      reset();
    }
}}
void detectContact(){
   for(int x = 0; x < rectList.size();x++){
      if(rectList.get(x).detectContactBounds(playerX,playerY,playerX + playerSize, playerY + playerSize)&& hitFrames == 0){
        hitFrames = 60;
        playerHealth--;
        if(stage == 1){
          reset();
          stage = x+2;
        }
      }
  }
  if(hitFrames > 0){
    hitFrames--;
  }
}
