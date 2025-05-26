import java.util.Scanner;
import processing.sound.*;
import java.util.ArrayDeque;
import java.util.Deque;
import java.io.FileNotFoundException;

SoundFile mapSound;
Deque<int[]> noteReader = new ArrayDeque<>();
int posOffset;
char[] keys1 = {'a', 's', 'd', 'f'};
char[] keys2 = {'k', 'l', ';', '\''};

int startTime;
float musicTime = 0;
int appearanceTime = 1500;
int validTime = 200;

Player[] players = {new Player(0, keys1), new Player(1, keys2)}; 

void setup() {
  size(1920, 1080);
  posOffset = (width / 2);
  
  try {
      File file = new File(dataPath("DriveRealFast/map.txt"));//1
      mapSound = new SoundFile(this, "DriveRealFast/audio.mp3");
      Scanner input = new Scanner(file);

      boolean reached = false;
      while(input.hasNextLine()){
        String line = input.nextLine();
        
        if (line.equals("[HitObjects]")){
          reached = true;
          continue;
        }
        
        if (reached){
          String[] data = line.split(",");
          
          int[] packed = {64, 0}; //time , type
          packed[0] = Math.round(parseFloat(data[2]));
          if(data[5].equals("L")){
           packed[1] = 1; 
          }else{
            packed[1] = 0;
          }
          noteReader.addLast(packed);
        
        }
        
        
      }
      
      mapSound.play();
      startTime = millis();
      input.close();

    } catch (FileNotFoundException ex) {
      //File not found what should you do?
      System.out.println("File not found");
      return; //you can return from a void function just don't put a value.
    }
    
}

void draw() {
  musicTime = millis() - startTime;
  
  background(0);
  fill(255);


   if (noteReader.size() > 0){
    while (noteReader.size() > 0 && noteReader.peekFirst()[0] <= musicTime + appearanceTime){
      int[] data = noteReader.removeFirst();
      
      for (int i = 0; i < players.length; i++){
        players[i].addNote(new Note(i, data[0], data[1]));
      }
    }
  }

  for (int i = 0; i < players.length; i++) {
    players[i].playerScreenRender();
  }

}

void keyPressed() {
  for (Player p : players) {
    p.keyPressed();
  }
}
