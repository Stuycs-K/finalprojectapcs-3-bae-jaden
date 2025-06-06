public class Confetti{
 PVector position;
 PVector velocity;
 float life;
 color currentColor;
 
 public Confetti(float xPos, float yPos, color chosenColor){
   currentColor = chosenColor;
   life = 60;
   position = new PVector(xPos, yPos);
   velocity = new PVector(random(-5,5), random(-50,-45));
 }
 
 boolean render(){
  position = new PVector(position.x + velocity.x, position.y + velocity.y);
  velocity.y += 1;
  life -= 1;
  noStroke();
  fill(currentColor);
  rect(position.x, position.y, 5, 5);
   return (life <= 0);
 }

  
}
