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
      ArrayList<Note> noteDeleteList = new ArrayList<Note>();
    
    for (Note h : noteList) {
      if (h.returnTime() > musicTime) {
        h.display();
      } else if (musicTime - h.returnTime() >= 0 && appearanceTime >= musicTime - h.returnTime()) {
        h.display();
      } else {
        noteDeleteList.add(h);
      }
    }

    for (Note h : noteDeleteList) {
      noteList.remove(h);
    }
    


    noteDeleteList = null;
    }
    

    for (Note h : deleteRender){
       h.display();
    }  

    if (deleteRender.size() > 0){     
      while (deleteRender.peekFirst().returnValid() == false){
        deleteRender.removeFirst();
        if (deleteRender.size() == 0){
         break; 
        }
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
      deleteRender.addLast(removed);
      removed.hit();
      
    }
  }
}
