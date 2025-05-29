public class Camera{
  PVector position;
  PVector destination;
  PVector origin = new PVector(0, 0);
  float lastCamChange;
  int camPivotDuration = 1000;
  
  public Camera(){
    position = new PVector(0, 0);
    destination = new PVector(0, 0);
  }
  
  void setDestination(float x, float y){
    destination = new PVector(x,y);
    lastCamChange = musicTime;
  }
  
  void renderCamera(){
    float t = constrain((float)(musicTime - lastCamChange) / camPivotDuration,0,1);
    float newX = lerp(origin.x, destination.x, sin(PI * t));
    float newY = lerp(origin.y, destination.y, sin(PI * t));
    position = new PVector(newX, newY);
  }
  
}
