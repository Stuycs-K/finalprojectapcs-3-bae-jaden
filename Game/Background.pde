public class Background{
  PImage tile;
  
  public Background(){
    tile = loadImage("Assets/Tile.png");
  }
  
  void renderBackground(){
    tint(255);
    float startx = (-currentCamera.globalPosition.x) % (width / 5) - (width / 5);
    for (int i = 0; i < 7; i++){
      image(tile, startx + (i * (width / 5)), 700 + currentCamera.offset.y);
    }
  }
  
}
