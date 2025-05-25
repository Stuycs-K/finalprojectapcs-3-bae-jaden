import java.util.ArrayDeque;
import java.util.Deque;


public class Player{
  Deque<Note>[] noteScore = (Deque<Note>[]) new Deque[4];
  int player;
  int score = 0;
  Deque<Note> deleteRender = new ArrayDeque<>();
  
  char[] keys = {'a','s','d','f'};
    
  public Player(int num, char[] chosenkey){
    player = num;
    noteScore[0] = new ArrayDeque<>();
    noteScore[1] = new ArrayDeque<>();
    noteScore[2] = new ArrayDeque<>();
    noteScore[3] = new ArrayDeque<>();
    keys = chosenkey;
    
  }
  
  
  void addNote(Note n){
    noteScore[n.returnLane()].addFirst(n);
  }
  
  void playerScreenRender(){
    for (Deque<Note> noteList : noteScore) {   
    for (Note h : noteList) {
       h.display();
   
      }
    
    }
  }
  
  void keyPressed(){
    int selectedLane = -1;
  
    if (key == keys[0]) {
      selectedLane = 0;
    } else if (key == keys[1]) {
      selectedLane = 1;
    } else if (key == keys[2]) {
      selectedLane = 2;
    } else if (key == keys[3]) {
      selectedLane = 3;
    } else{
     return; 
    }
    
    if (selectedLane != -1 && noteScore[selectedLane].size() > 0) {
      Note removed = noteScore[selectedLane].removeLast();
      removed.hit();
      
    }
  }
}
