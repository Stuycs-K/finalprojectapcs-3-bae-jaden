public class Camera{
  PVector globalPosition;
  PVector offset;
  PVector start;
  PVector finish;
  PVector destination;
  PVector origin = new PVector(0, 0);
  float lastCamChange;
  int camPivotDuration = 500;
  
  public Camera(){
    offset = new PVector(0, 0);
    globalPosition = new PVector(0,0);
    destination = new PVector(0, 0);
    start = new PVector(0,0);
    finish = new PVector(0,0);
  }
  
  void setDestination(float x, float y){
    destination = new PVector(-(x/4),(y/4));
    start = new PVector(globalPosition.x, globalPosition.y);
    finish = new PVector(globalPosition.x + x, globalPosition.y + y);
    lastCamChange = musicTime;
  }
  
  void renderCamera(){
    //offset Change
    float t = constrain((float)(musicTime - lastCamChange) / camPivotDuration,0,1);
    float newX = lerp(origin.x, destination.x, sin(PI * t));
    float newY = lerp(origin.y, destination.y, sin(PI * t));
    offset = new PVector(newX, newY);
    
    //globalPosition change
    float t2 = constrain((float)(musicTime - lastCamChange) / (camPivotDuration / 2),0,1);
    globalPosition.x = lerp(start.x, finish.x, t2);
  }
  
}
