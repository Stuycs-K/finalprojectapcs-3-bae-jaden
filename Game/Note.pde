public class Note{
 PVector position;
 float finalRadius = 100;
 float startRadius = 500;
 int lane;
 int time;
 boolean valid = true;
 boolean hit = false;
 
 boolean returnValid(){
  return (valid); 
 }
 
 void hit(){
  hit = true; 
 }
 int returnTime(){
  return (time); 
 }  
 
 int returnLane(){
   return (lane);
 }  
 
 public Note(int pickedTime, int chosenlane, int player, int x, int y) {
   valid = true;
   time = pickedTime;
   lane = chosenlane;
   position = new PVector(x + posOffset * player, y);
  }
  
  
 void display(){
   float t;
   color chosenColor;
   float alpha;
   if (!hit){
     t = constrain((float)(musicTime - (time - appearanceTime)) / appearanceTime, 0, 1);
     alpha = constrain(lerp(0, 255, t) * 2, 0, 255);
     
   }else{
     t = constrain((float)(musicTime - time) / (appearanceTime * 0.5), 0, 1);
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
     stroke(255,255,255,alpha);
     strokeWeight(12);
     circle(position.x, position.y, finalRadius);
     
     
     float radius = lerp(startRadius, finalRadius, t);
    
     noFill();
     stroke(chosenColor);
     strokeWeight(4);
     circle(position.x, position.y, radius);
     
   }else{
     stroke(255,255,255,alpha);
     strokeWeight(12);
     float radius = lerp(finalRadius, (startRadius - (startRadius - finalRadius) / 1.5), t);
     circle(position.x, position.y, radius); 
     
     if (t == 1){
      valid = false; 
     }
   }
   
 }
}
