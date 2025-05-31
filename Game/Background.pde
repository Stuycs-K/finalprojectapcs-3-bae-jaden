public class Background{
  PImage tile;
  
  public Background(){
    tile = loadImage("Assets/Tile.png");
  }
  
  void renderBackground(){
    tint(255);
    
    //background
    imageMode(CENTER);
    float backXPos = width / 2 + ((-currentCamera.globalPosition.x) - currentCamera.offset.x) / 12;
    float backYPos = height / 2 + (currentCamera.globalPosition.y + currentCamera.offset.y) / 12;
    
    currentCamera.applyZoomImage(backdrop, backXPos, backYPos,1);
    
    
    //foreground
    imageMode(CORNER);  
    float startx = (-currentCamera.globalPosition.x) % (width / 5) - (width / 5);

    for (int i = 0; i < 8; i++){
      float tileXPos = startx + (i * (width / 5)) - currentCamera.offset.x;
      float tileYPos = 800 + currentCamera.offset.y;
      
      currentCamera.applyZoomImage(tile,tileXPos, tileYPos, 1);
    }
  }
  
}
