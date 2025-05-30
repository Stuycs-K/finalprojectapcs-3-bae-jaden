public class Background{
  PImage tile;
  
  public Background(){
    tile = loadImage("Assets/Tile.png");
  }
  
  void renderBackground(){
    tint(255);
    
    //background
    imageMode(CENTER);
    image(backdrop, width / 2 + ((-currentCamera.globalPosition.x) - currentCamera.offset.x) / 12, height / 2 + (currentCamera.globalPosition.y + currentCamera.offset.y) / 12);
    
    
    //foreground
    imageMode(CORNER);  
    float startx = (-currentCamera.globalPosition.x) % (width / 5) - (width / 5);
    for (int i = 0; i < 8; i++){
      image(tile, startx + (i * (width / 5)) - currentCamera.offset.x, 800 + currentCamera.offset.y, currentCamera.currentZoom * tile.width, currentCamera.currentZoom * tile.height);
    }
  }
  
}
