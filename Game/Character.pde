public class Character{
  int player;
  String chosenCharacter;
  PImage spriteSheet;
  PImage currentImage;
  PVector position;
  
  void renderPlayerChar(){

    if (players[player].fakeOut){
      tint(255, 73, 28);
    }else if (players[player].vulnerable){
      tint(255, 0, 0);
    }else{
      tint(255);
    }
   pushMatrix();
   if (player == 1){
    scale(-1, 1); 
    image(currentImage, -(int) (width/2 + (300 * Math.pow(-1, player + 1))) - currentImage.width / 2, height / 2 - currentImage.height / 2);
   }else{
    scale (1, 1); 
    image(currentImage, (int) (width/2 + (300 * Math.pow(-1, player + 1))) - currentImage.width / 2, height / 2 - currentImage.height / 2);
   }
    popMatrix();
  }
  
  public Character(int playernum, String chosenCharacterName){
    player = playernum;
    chosenCharacter = chosenCharacterName;
    
    spriteSheet = loadImage("Characters/" + chosenCharacter + "/sprite.png");
    currentImage = spriteSheet.get(0,0, width/4 , height / 2);
  }
  
}
