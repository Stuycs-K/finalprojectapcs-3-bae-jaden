public class TitleScreen{
  boolean active;
  PImage background = loadImage("Assets/Title/Background.png");
  PImage title = loadImage("Assets/Title/Title.png");
  PImage instruction = loadImage("Assets/Title/Instruction.png");
  
  
  float smoothedAdjustment = 1.0;

  void render(){
    imageMode(CENTER);
  
    float target = (volume / 4.0) + 0.825;
    smoothedAdjustment = lerp(smoothedAdjustment, target, 0.01);
  
    image(background, width / 2, height / 2);
    image(title, width / 2, height / 2, smoothedAdjustment * title.width, smoothedAdjustment * title.height);
    image(instruction, width / 2, height / 2, smoothedAdjustment * instruction.width, smoothedAdjustment * instruction.height);
  }
  
  public TitleScreen(){
    active = true;
  }
  
}
