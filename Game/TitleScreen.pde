public class TitleScreen{
  boolean active;
  PImage background = loadImage("Assets/Title/Background.png");
  PImage title = loadImage("Assets/Title/Title.png");
  PImage instruction = loadImage("Assets/Title/Instruction.png");
  
  float smoothedAdjustment = 1.0;
  float smoothedAdjustment1 = 1.0;
  
  void render(){
    imageMode(CENTER);

    float adjustment = (volume / 4) + 0.825;
    smoothedAdjustment = lerp(smoothedAdjustment, adjustment, 0.2);
    
    println(smoothedAdjustment);
    if (smoothedAdjustment > 1.05){
     currentConfettiManager.spawnBurst(100, color(88,29,255)); 
      
    }
    smoothedAdjustment1 = lerp(smoothedAdjustment1, adjustment, 0.1);
    
    image(background, width / 2, height / 2);
    
    image(title, width / 2, height / 2, smoothedAdjustment * title.width, smoothedAdjustment * title.height);
    
    image(instruction, width / 2, height / 2, smoothedAdjustment1 * instruction.width, smoothedAdjustment1 * instruction.height );
    currentConfettiManager.renderConfetti();
  }
  
  public TitleScreen(){
    active = true;
  }
  
}
