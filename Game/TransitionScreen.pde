public class TransitionScreen{
  int life = 10;
  void render(){
    background(0);
    textSize(40);
    text("Transition", width / 2, height / 2); 
    if (life > 0){
      life -= 1;
    }
  }
  
  public TransitionScreen(){
    life = 60;
  }
  
}
