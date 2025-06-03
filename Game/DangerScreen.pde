public class DangerScreen{
  PImage Screenlayer;
  int life = 60;
  
  public DangerScreen(){
    Screenlayer = dangerStatus;
  }
  
  void render(){
    pushMatrix();
    if (currentPosScore > 0){    
      scale(-1, 1); 
      image(Screenlayer, - width, 0);
    }else if (currentPosScore < 0){
      scale(1, 1); 
      image(Screenlayer, 0, 0);
    }else{
      popMatrix();
     return; 
    }
    scale(1, 1); 
    popMatrix();
  }
  
}
