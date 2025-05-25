import java.util.Scanner;
import processing.sound.*;
import java.util.ArrayDeque;
import java.util.Deque;
import java.io.FileNotFoundException;

SoundFile mapSound;
Deque<int[]> noteReader = new ArrayDeque<>();
int posOffset;
char[] keys1 = {'a', 's', 'k', 'l'};
char[] keys2 = {'x', 'z', ';', '\''};
int yCurrent;
int startTime;
float musicTime = 0;
int appearanceTime = 500;


Player[] players = {new Player(0, keys1), new Player(1, keys2)}; 

void setup() {
  size(1920, 1080);
  posOffset = (width / 2);
  
  try {
      File file = new File(dataPath("GameOn/map.txt"));//1
      mapSound = new SoundFile(this, "GameOn/audio.mp3");
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
          int[] packed = {64, 0, 0, 1};
          for (int i = 0; i < 4; i++){
            if (i == 2) { 
              packed[i] = Math.round(parseFloat(data[i]));
            } else if (i == 0) { 
              packed[i] = Math.round(parseFloat(data[i]) * (960.0 / 512.0));
            } else if (i == 1) { 
              packed[i] = Math.round(parseFloat(data[i]) * (1080.0 / 384.0));
            } else {
              packed[i] = parseInt(data[i]);
            }
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

  yCurrent += 5;
  if (yCurrent > height) {
    yCurrent = 0;
  }

   if (noteReader.size() > 0){
    while (noteReader.size() > 0 && noteReader.peekFirst()[2] <= musicTime + appearanceTime){
      int[] data = noteReader.removeFirst();
      int lane = 0;
      if (data[0] > 0 && data[0] <= Math.round(parseFloat(127) * (960.0 / 512.0))){
        lane = 0;
      }else if (data[0] > Math.round(parseFloat(127) * (960.0 / 512.0)) && data[0] <= Math.round(parseFloat(255) * (960.0 / 512.0))){
        lane = 1;
      }else if (data[0] > Math.round(parseFloat(255) * (960.0 / 512.0)) && data[0] <= Math.round(parseFloat(383) * (960.0 / 512.0))){
        lane = 2;
      }else if (data[0] > Math.round(parseFloat(383) * (960.0 / 512.0)) && data[0] <= Math.round(parseFloat(511) * (960.0 / 512.0))){
        lane = 3;
      }
      
      for (int i = 0; i < players.length; i++){
        players[i].addNote(new Note(data[2], lane, i, data[0], data[1]));
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
