public class TitleScreen{
  boolean active;
  void render(){
    background(0);
    textSize(40);
    text("BEAT BOXING: PRESS ANY KEY TO CONTINUE", width / 2, height / 2); 
  }
  
  public TitleScreen(){
    active = true;
  }
  
}
