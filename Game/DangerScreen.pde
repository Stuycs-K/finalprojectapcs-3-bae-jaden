public class DangerScreen{
  PImage Screenlayer;
  int life = 60;
  
  public DangerScreen(){
    Screenlayer = dangerStatus;
  }
  
  void render(){
    pushMatrix();
    if (currentPosScore > 7){     
      scale(-1, 1); 
    }else if (currentPosScore < -7){
      scale(1, 1); 
    }else{
     return; 
    }
    
    image(Screenlayer, 0, 0);
    scale(1, 1); 
    popMatrix();
  }
  
}
