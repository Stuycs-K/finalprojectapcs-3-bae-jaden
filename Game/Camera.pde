public class Camera{
  PVector position;
  PVector destination;
  float lastCamChange;
  int camPivotDuration = 1000;
  
  public Camera(){
    position = new PVector(width / 2, height/2);
    destination = new PVector(width / 2, height/2);
  }
  
  void setDestination(float x, float y){
    destination = new PVector(x,y);
    lastCamChange = musicTime;
  }
  
  void renderCamera(){
    float t = (float)(musicTime - (lastCamChange + camPivotDuration)) / camPivotDuration;
    float newX = lerp(position.x, destination.x, (-cos(PI * t)) / 2 + 0.5);
    float newY = lerp(position.y, destination.y, (-cos(PI * t)) / 2 + 0.5);
    position = new PVector(newX, newY);
    rect(position.x, position.y, 20,20);
  }
  
}
