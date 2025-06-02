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
    
    
    //middleground
    float middleXPos = width / 2 + ((-currentCamera.globalPosition.x) - currentCamera.offset.x) / 8;
    float middleYPos = height / 2 + (currentCamera.globalPosition.y + currentCamera.offset.y) / 8;
    
    currentCamera.applyZoomImage(crowd, middleXPos, middleYPos + 100,1);
    
    //foreground
    imageMode(CORNER);  
    float startx = (-currentCamera.globalPosition.x) % (width / 5) - (width / 5);

    for (int i = 0; i < 8; i++){
      float tileXPos = startx + (i * (width / 5)) - currentCamera.offset.x;
      float tileYPos = 800 + currentCamera.offset.y;
      
      currentCamera.applyZoomImage(tile,tileXPos, tileYPos, 1);
    }
    
    //UIs
    
    rectMode(CORNER);
    float UIpos = 0;
    fill(74, 228, 255);
    noStroke();
    rect(UIpos, 100, (width * 0.5) + (width * 0.5) * (currentPosScore * 0.1), 30); //plr zero 
    
    UIpos = (width * 0.5) + (width * 0.5) * (currentPosScore * 0.1);
    fill(255, 74, 83);
    rect(UIpos, 100, (width * 0.5) + (width * 0.5) * (-currentPosScore * 0.1), 30); //plr one
    
    fill(255);
    
  }
  
}
