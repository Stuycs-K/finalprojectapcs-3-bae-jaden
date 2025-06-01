public class Note{
 PVector position;
 int lane;
 int time;
 boolean valid;
 boolean hit = false;
 boolean dead = false;
 boolean missed = false;
 
 boolean isLong;
 boolean longNoteActive = false;
 int longNoteduration;
 float tailY;
 float tailStartY;
 int tailStartTime;
 float tailProgress;
 float offset;
 int longNoteStack;
 int owner;

 float startY = -100;        
 float endY = height - 300;
 float speed = endY - startY;
 
 boolean returnValid(){
  return (valid); 
 }
 
 boolean hit(){
  if (isLong){
    if (!longNoteActive){
     hit = true; 
     tailY = endY - offset;
     longNoteActive = true;
     tailStartTime = (int) musicTime;
     tailStartY = position.y - offset;
     players[owner].combo ++;
     players[owner].energy ++;
     pressure++;
     return false;
      
    }else{
     longNoteStack ++;
     println("longNoteStack");
     players[owner].combo ++;
     players[owner].energy ++;
     pressure++;
     return false;
      
    }
  }
  
  float offset = abs(musicTime - time);
  if (offset <= validTime/4){
    println("perfect"+ offset);
    players[owner].EffectRender.add(new Effect(owner, perfectImage));
    pressure++;
    players[owner].combo ++;
    players[owner].energy ++;
  }else{
    println("bad" + offset);
    players[owner].EffectRender.add(new Effect(owner, badImage));
    players[owner].combo = 0;
    players[owner].vulnerable = true;
    players[owner].fakeOut = false;
    players[owner].lastVulnerable = (int)musicTime;
  }
  
  hit = true; 
  return true;
 }

 public Note(int player, int pickedTime, int type, int len) {
   owner = player;
   valid = false;
   time = pickedTime;
   position = new PVector((int) (width/2 + (100 * Math.pow(-1, player + 1))), startY);
   
   if (type == 0){
     isLong = false;
   }else{
     isLong = true;
     longNoteStack = 0;
     longNoteduration = len;
     offset = longNoteduration * ((endY - startY) / appearanceTime);
     tailY = position.y - offset;
   }
  }
  
  
 void display(){
   float t;
   color chosenColor;
   float alpha = 255;
   
   if (isLong){
     valid = (musicTime >= time - validTime) && (musicTime <= time + longNoteduration);
   }else{  
     valid = abs(time - musicTime) <= validTime;
   }

   
   
   if (!hit){
     t = (float)(musicTime - (time - appearanceTime)) / appearanceTime;
     alpha = 255;
   }else{
     t = constrain((float)(musicTime - time) / (appearanceTime * 0.05), 0, 1);
     if (!isLong){
        alpha = constrain(lerp(255, 0, t), 0, 255);
     }
     
   }
   
   if (lane == 0){
     chosenColor = color(143, 48, 199, alpha);
   }else if (lane == 1){
     chosenColor = color(48, 181, 199, alpha);
   }else if (lane == 2){
     chosenColor = color(48, 199, 58, alpha);
   }else{
     chosenColor = color(199, 48, 53, alpha);
   }
   
   fill(chosenColor);
   
   if (!hit){
     if (t <= 1){
       position.y = lerp(startY, endY, t);
     }else{
       position.y = endY + speed * (t-1);
     }
     
     if(musicTime > time + validTime && missed == false && players[owner].guard == false){
        missed = true;
        players[owner].combo = 0;
        players[owner].vulnerable = true;
        players[owner].fakeOut = false;
        players[owner].lastVulnerable = (int)musicTime;
        players[owner].EffectRender.add(new Effect(owner, missImage));
     }
     tailY = position.y - offset;
     stroke(255,255,255,alpha);
     
     if(isLong){
       strokeWeight(100);
       line(position.x, position.y, position.x, tailY);
       strokeWeight(12);
       circle(position.x, position.y - offset, 100); 
     }
     
     strokeWeight(12);
     circle(position.x, position.y, 100);
     
   }else{
     
     stroke(255,255,255,alpha);
     strokeWeight(12);
     float radius = lerp(100, 150, t);
     
     if (isLong){
       strokeWeight(100);
       tailProgress = constrain((musicTime - time) / (float)longNoteduration, 0, 1);
       tailY = lerp(tailStartY, position.y, tailProgress);
       
       line(position.x, position.y, position.x, tailY);
       strokeWeight(12);
       circle(position.x, tailY, 100); 
     }else{
       circle(position.x, position.y, radius); 
       
     }
     
     
     
     if(musicTime > time + validTime && players[owner].vulnerable == true){
        players[owner].vulnerable = false;
     }
     
     if (isLong){
       if (tailProgress >= 1){
         dead = true;
       }
     }else{
       if (t >= 1){
        dead = true;
       }
     }
     

   }
   
 }
}
