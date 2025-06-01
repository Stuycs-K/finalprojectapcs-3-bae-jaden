public class Camera{
  PVector globalPosition;
  PVector offset;
  PVector start;
  PVector finish;
  PVector destination;
  PVector origin = new PVector(0, 0);
  float lastCamChange;
  int camPivotDuration = 500;
  
  float zoomStart;
  float zoomEnd;
  float lastZoom;
  float currentZoom;
  boolean zoomReturning;
  int zoomDuration = 1000;
  float sineT;
  
  void applyZoomImage(PImage image, float posx, float posy, int xscale){
   float XOffset;
   float YOffset = posy - (height / 2);
     
   if (xscale == 1){
     XOffset = posx - (width / 2);
     
   }else{
     XOffset = posx + width / 2;
   }
   
   float YScale = currentCamera.currentZoom * image.height;
   float Ypos = posy + YOffset * (currentCamera.currentZoom - 1);
   if (image == crowd){
     YScale += (sineT * image.height * 0.2);
     Ypos -= (sineT * image.height * 0.3);
   }
   image(image, posx + XOffset * (currentCamera.currentZoom - 1), Ypos, currentCamera.currentZoom * image.width, YScale); 
   
    
  }
  public Camera(){
    offset = new PVector(0, 0);
    globalPosition = new PVector(0,0);
    destination = new PVector(0, 0);
    start = new PVector(0,0);
    finish = new PVector(0,0);
    
    zoomStart = 1;
    currentZoom = 1;
    zoomEnd = 1;
  }
  
  void renderImage(){
    
  }
  
  void zoom(float zoomvalue){
    if (zoomReturning){
     return; 
    }
    zoomEnd = zoomvalue;
    
    
    if (zoomvalue > 1){
      currentZoom = (currentZoom - zoomStart) / 2 + zoomStart;
      zoomStart = currentZoom;
    }else{
      currentZoom = zoomStart;
      zoomStart = currentZoom;
      zoomReturning = true;
    }
    
    lastZoom = musicTime;
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
    
    //zoomChange
    float t3 = constrain((float)(musicTime - lastZoom) / (zoomDuration),0,1);
    currentZoom = lerp(zoomStart, zoomEnd, sin(PI / 2 * t3));
    if (t3 == 1 && zoomReturning == true){
      zoomReturning = false;
      currentZoom = 1;
      zoomStart = 1;
    }
    
    //sinWaveChange
    float t4 = constrain((float)(musicTime - lastZoom) / (zoomDuration / 2),0,1);
    sineT = sin(PI * t4);
  }
  
}
