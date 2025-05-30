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
    
    float backXOffset = backXPos - (width / 2);
    float backYOffset = backYPos - (height / 2);
    
    image(backdrop, backXPos + backXOffset * (currentCamera.currentZoom - 1), backYPos + backYOffset * (currentCamera.currentZoom - 1), currentCamera.currentZoom * backdrop.width, currentCamera.currentZoom * backdrop.height);
    
    
    //foreground
    imageMode(CORNER);  
    float startx = (-currentCamera.globalPosition.x) % (width / 5) - (width / 5);

    for (int i = 0; i < 8; i++){
      float tileXPos = startx + (i * (width / 5)) - currentCamera.offset.x;
      float tileYPos = 800 + currentCamera.offset.y;
      
      float xOffset = tileXPos - (width / 2);
      float yOffset = tileYPos - (height / 2);
      
      image(tile, tileXPos + xOffset * (currentCamera.currentZoom - 1), tileYPos + yOffset * (currentCamera.currentZoom - 1),currentCamera.currentZoom * tile.width, currentCamera.currentZoom * tile.height);
    }
  }
  
}
