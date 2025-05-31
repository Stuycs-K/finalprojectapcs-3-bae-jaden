public class Character{
  int player;
  String chosenCharacter;
  PImage spriteSheet;
  PImage currentImage;
  PVector position;
  int lastAction;
  
  String currentStatus = "default";
  
  void idle(){
    if (!currentStatus.equals("idle")){
      currentImage = spriteSheet.get(0,0, width/4 , height / 2);
      currentStatus = "idle";
    }
  }
  
  void attack(){
    if (!currentStatus.equals("attack")){
      currentImage = spriteSheet.get(width/4 * int(random(1, 3)) ,0, width/4 , height / 2);
      lastAction = (int)musicTime;
      currentStatus = "attack";
    }
    

  }
  
  void capture(){
    if (!currentStatus.equals("capture")){
      currentImage = spriteSheet.get(0 ,height / 2, width/4 , height / 2);
      lastAction = (int)musicTime;
      currentStatus = "capture";
    }

  }
  
  void fling(){
    if (!currentStatus.equals("fling")){
      currentImage = spriteSheet.get(width/4 ,height / 2, width/4 , height / 2);
      lastAction = (int)musicTime;
      currentStatus = "fling";
    }

  }
  
  void vulnerable(){
    if (!currentStatus.equals("vulnerable")){
      currentImage = spriteSheet.get(width/2 ,height / 2, width/4 , height / 2);
      lastAction = (int)musicTime;
      currentStatus = "vulnerable";
    }

  }
  
  void fakeout(){
    if (!currentStatus.equals("fakeout")){
      currentImage = spriteSheet.get(width/4 * 3 ,height / 2, width/4 , height / 2);
      lastAction = (int)musicTime;
      currentStatus = "fakeout";
    }
  }
  
  void renderPlayerChar(){
    if (musicTime - lastAction > validTime && currentStatus.equals("attack")){
      idle();
    }
    if (players[player].fakeOut){
      fakeout();
      tint(255, 73, 28);
    }else if (players[player].vulnerable){
      vulnerable();
      tint(255, 0, 0);
    }else if (!players[player].vulnerable && !players[player].fakeOut && !currentStatus.equals("attack")){
      idle();
      tint(255);
    }else{
      tint(255);
    }
    
 
   
   pushMatrix();
   if (player == 1){
    scale(-1, 1); 
    position = new PVector(-(int) (width/2 + (150 * Math.pow(-1, player + 1))) - currentImage.width / 2, 50 + height / 2 - currentImage.height / 2);
    currentCamera.applyZoomImage(currentImage,position.x + currentCamera.offset.x, position.y + currentCamera.offset.y, -1);
   }else{
    scale (1, 1); 
    position = new PVector((int) (width/2 + (150 * Math.pow(-1, player + 1))) - currentImage.width / 2, 50 + height / 2 - currentImage.height / 2);
    currentCamera.applyZoomImage(currentImage, position.x - currentCamera.offset.x, position.y + currentCamera.offset.y, 1);
   }
    popMatrix();
  }
  
  public Character(int playernum, String chosenCharacterName){
    player = playernum;
    chosenCharacter = chosenCharacterName;
    
    spriteSheet = loadImage("Characters/" + chosenCharacter + "/sprite.png");
    idle();
  }
  
}
