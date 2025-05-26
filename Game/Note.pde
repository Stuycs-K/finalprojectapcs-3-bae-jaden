public class Note{
 PVector position;
 int lane;
 int time;
 boolean valid;
 boolean hit = false;
 boolean dead = false;
 boolean isLong;
 int longNoteStack;
 int owner;
 
 float startY = -100;        
 float endY = height - 300;
 float speed = endY - startY;
 
 boolean returnValid(){
  return (valid); 
 }
 
 void hit(){
  hit = true; 
 }

 public Note(int player, int pickedTime, int type) {
   owner = player;
   valid = false;
   time = pickedTime;
   if (type == 0){
     isLong = true;
     longNoteStack = 0;
   }else{
     isLong = false;
   }
   
   position = new PVector((int) (width/2 + (100 * Math.pow(-1, player + 1))), startY);
  }
  
  
 void display(){
   float t;
   color chosenColor;
   float alpha;
   
   if (abs(time - musicTime) <= validTime){
     valid = true;
   }else{
     valid = false;
   }
   
   
   if (!hit){
     t = (float)(musicTime - (time - appearanceTime)) / appearanceTime;
     alpha = 255;
   }else{
     t = constrain((float)(musicTime - time) / (appearanceTime * 0.05), 0, 1);
     alpha = constrain(lerp(255, 0, t), 0, 255);
     
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
     stroke(255,255,255,alpha);
     strokeWeight(12);
     
     circle(position.x, position.y, 100);
     
   }else{
     stroke(255,255,255,alpha);
     strokeWeight(12);
     float radius = lerp(100, 150, t);
     circle(position.x, position.y, radius); 
     
     if (t >= 1){
      dead = true;
     }
   }
   
 }
}
