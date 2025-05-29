import java.util.ArrayDeque;
import java.util.Deque;

public class Player{
  Deque<Note> noteScore = new ArrayDeque<>();
  int player;
  int combo = 0;
 
  boolean vulnerable = false;
  int lastVulnerable;
  
  boolean guard = false;
  int lastGuard;
  
  boolean fakeOut = false;
  int lastFakeOut;
  
  ArrayList<Note> noteDeleteList = new ArrayList<Note>();
  Deque<Note> deleteRender = new ArrayDeque<>();
  
  boolean Pressed0 = false;
  boolean Pressed1 = false;
  boolean Pressed2 = false;
  boolean Pressed3 = false;
  char[] keys = {'a','s','d','f'};
  
  Character currentChar;
  
  public Player(int num, char[] chosenkey, String chosenCharacter){
    player = num;
    keys = chosenkey;
    currentChar = new Character(num, chosenCharacter);
  }
  
  void fakeOut(){
    if (vulnerable == false && musicTime > lastFakeOut + tickInterval){
      //fakeOut = true;
      //lastFakeOut = (int)musicTime;
      return;
    }
  }
  
  void capture(){
    if (players[(player + 1) % 2].vulnerable == true){
      players[(player + 1) % 2].vulnerable = false;
      vulnerable = false;
      guard = true;
      lastGuard = (int) musicTime;
      currentPosScore += Math.pow(-1, player);
    }else if (players[(player + 1) % 2].fakeOut == true){
      players[(player + 1) % 2].fakeOut = false;
      currentPosScore += Math.pow(-1, (player + 1) % 2);
    }else{
      vulnerable = true;
      lastVulnerable = (int) musicTime;
    }
  }
  
  void addNote(Note n){
    noteScore.addFirst(n);
  }
 
 void playerCharRender(){
   //combo display
   
   textSize(30);
   fill(255);
   text("Combo: " + combo, (int) (width/2 + (300 * Math.pow(-1, player + 1))), height / 2);
   
    
   if (musicTime > lastVulnerable + tickInterval * 2){
     vulnerable = false;
   }
   
   if (musicTime > lastFakeOut + tickInterval){
     fakeOut = false;
   }
   
   if (musicTime > lastGuard + tickInterval * 2){
     guard = false;
   }
   
   currentChar.renderPlayerChar();
 }
 
 void playerNoteRender(){
    noFill();
    stroke(255);
    strokeWeight(2); 
    circle((int) (width/2 + (100 * Math.pow(-1, player + 1))), height - 300, 100);
    for (Note h : noteScore) {
      if (h.time > musicTime) {
        h.display();
      } else if (musicTime - h.time  >= 0 && appearanceTime >= musicTime -h.time ) {
        h.display();
      } else {
        noteDeleteList.add(h);
      }
    }

    for (Note h : noteDeleteList) {
      noteScore.remove(h);
    }
    
    noteDeleteList.clear();
    

    for (Note h : deleteRender){
       h.display();
    }  

    if (deleteRender.size() > 0){     
      while (deleteRender.peekFirst().dead  == true){
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
      Pressed0 = true;
    } else if (key == keys[1]) {
      selectedLane = 0;
      Pressed1 = true;
    } else if (key == keys[2]) {
      selectedLane = 0;
      Pressed2 = true;
    } else if (key == keys[3]) {
      Pressed3 = true;
    } else{
     return; 
    }
    
    if (selectedLane != -1 && noteScore.size() > 0) {
      ArrayList<Note> noteTempList = new ArrayList<Note>();
      
      while (noteScore.size() > 0 && !noteScore.peekLast().valid){
        noteTempList.add(noteScore.removeLast());
      }
      
      if (noteScore.size() == 0){
        println("no valid notes!");
      }else{
        metronomeTick.play();
        currentChar.attack();
        if (noteScore.peekLast().hit() && !noteScore.peekLast().isLong){
          Note removed = noteScore.removeLast();
          deleteRender.addLast(removed);
        }

        
      }
      
      for (Note j : noteTempList){
        if (!j.dead){
           noteScore.addLast(j);
        }
          
      }

      
    }else if (Pressed0 || Pressed3){
      if (player == 0){
        if (key == keys[3]){
          capture();
        }else{
          fakeOut();
        }
      
      }else{
        if (key == keys[0]){
          capture();
        }else{
          fakeOut();
        }
      }
    }
  }
}
