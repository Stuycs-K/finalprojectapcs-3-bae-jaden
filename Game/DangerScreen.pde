public class DangerScreen{
  PImage Screenlayer;
  int life = 60;
  float startTime;
  
  
  public DangerScreen(){
    Screenlayer = dangerStatus;
  }
  
  void render(){
    if (!(currentPosScore > 0) && !(currentPosScore <0)){
      return;
    }
    pushMatrix();
    float opacity = (sin(PI * (musicTime / 450.0)) + 1) / 2 * 255;
    tint(255, opacity);
    if (currentPosScore > 0){    
      startTime = musicTime;
      scale(-1, 1); 
      
      image(Screenlayer, - width, 0);
    }else if (currentPosScore < 0){
      startTime = musicTime;
      scale(1, 1); 
      
      image(Screenlayer, 0, 0);
    }
    
    scale(1, 1); 
    tint(255,255);
    popMatrix();
  }
  
}
