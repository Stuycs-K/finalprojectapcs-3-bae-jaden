public class ConfettiManager{
 ArrayList<Confetti> confettiList;
 
 void spawnBurst(int numb, color chosenColor){
   float xpos = (int)random(0, 5) * width / 5;
  for (int i = 0; i < numb; i++){
    println("added");
   confettiList.add(new Confetti(xpos, height, chosenColor)); 
  }
   
 }
 
 void renderConfetti(){
  for (int i = confettiList.size() - 1; i >= 0; i--) {
    Confetti c = confettiList.get(i);
    if (c.render()){
       confettiList.remove(i);
    }
  }
   
 }
 public ConfettiManager(){
   confettiList = new ArrayList<Confetti>();
   
 }
}
