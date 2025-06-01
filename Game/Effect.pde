public class Effect{
  PVector position;
  int transparency;
  int life;
  PImage chosenImage;
  
  boolean Display(){
   if (life > 0){
    position = new PVector(position.x, position.y - 1);
    transparency = (int)(255 * pow(life / 60.0, 3));
    tint(255, transparency);
    image(chosenImage, position.x, position.y);
    life --; 
    return true;
   }else{
     return false;
   }
  }
  
  public Effect(int player, PImage type) {
   transparency = 255;
   chosenImage = type;
   life = 60;
   position = new PVector(posOffset * player + (posOffset / 2), height / 2);
  }
}
