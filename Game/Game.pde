import java.util.Scanner;
import processing.sound.*;
import java.util.ArrayDeque;
import java.util.Deque;
import java.io.FileNotFoundException;

SoundFile mapSound;
SoundFile metronomeTick;

Deque<int[]> noteReader;
int posOffset;
char[] keys1 = {'a', 's', 'd', 'f'};
char[] keys2 = {'k', 'l', ';', '\''};

int startTime;
float musicTime = 0;
int appearanceTime;
int validTime = 150;
int tickInterval;
int BPM;
int lastMetronomeTick = 0;
int preSongCount = 0;
int currentPosScore = 0;

int pressure = 0;

int intermissionTimerMax = 60;
int intermissionTimer = intermissionTimerMax;

boolean gameEnd;
boolean gameActive;
boolean gameSetUpDone;

PImage backdrop, crowd, rope, pole;


PImage perfectImage, badImage, missImage, hitImage;

PImage dangerStatus;

String currentMenu;

SongMenu Songscreen;
CharSelectionScreen charscreen;
Camera currentCamera;
Background currentBackground;
DangerScreen currentDangerScreen;
TransitionScreen currentTransitionScreen;
TitleScreen currentTitleScreen;

Player[] players; 

Amplitude amp;
float volume = 0;

ConfettiManager currentConfettiManager;

void randomSongPlay(){
  if (mapSound != null){
    mapSound.stop();
    mapSound = null;
    amp.input(null);
  }
  
 int randomIndexSong = (int)(Math.random() * Songscreen.ListOfSong.size());
  mapSound = new SoundFile(this, Songscreen.ListOfSong.get(randomIndexSong)[2]);
  mapSound.play(); 
  
  amp.input(mapSound);
  
}
void setup() {
  
  size(1920, 1080, P2D);
  fullScreen(P2D);
  posOffset = (width / 2);
  gameEnd = false;
  gameActive = false;
  Songscreen = new SongMenu(this);
  charscreen = new CharSelectionScreen();
  currentTransitionScreen = new TransitionScreen();
  currentConfettiManager = new ConfettiManager();
  currentTitleScreen = new TitleScreen();
  
  currentMenu = "TitleScreen";
  //assetsLoad
  backdrop = loadImage("Assets/Backdrop.png");
  crowd = loadImage("Assets/Crowd.png");
  rope = loadImage("Assets/Rope.png");
  pole = loadImage("Assets/Pole.png");
  
  perfectImage = loadImage("Assets/Perfect.png");
  badImage = loadImage("Assets/Bad.png");
  missImage = loadImage("Assets/Miss.png");
  hitImage = loadImage("Assets/Hit.png");
  dangerStatus = loadImage("Assets/Danger.png");
  
  amp = new Amplitude(this);
  //song play
  randomSongPlay();
  println("played");
  
  
}

void cleanUp(){
  gameActive = false;
  gameSetUpDone = false;
  intermissionTimer = intermissionTimerMax;
  startTime = 0;
  musicTime = 0;
  lastMetronomeTick = 0;
  preSongCount = 0;
  currentPosScore = 0;
  currentTransitionScreen = new TransitionScreen();
  
  if (mapSound != null) {
    mapSound.stop();
    mapSound = null;
  }
  noteReader = null;
  players = null;
}
void loadGame(){
  gameEnd = false;
  players = new Player[] {new Player(0, keys1, Songscreen.player1Character), new Player(1, keys2, Songscreen.player2Character)}; 
  currentCamera = new Camera();
  currentBackground = new Background();
  currentDangerScreen = new DangerScreen();
  pressure = 0;
  noteReader = new ArrayDeque<>();
    try {
      File file = new File(dataPath(Songscreen.ChosenSong[1]));
      
      metronomeTick = new SoundFile(this, "metronomeTick.mp3");
      Scanner input = new Scanner(file, "UTF-8");
      System.out.println(file.exists());
      System.out.println(file.length());
      boolean reached = false;
      while(input.hasNextLine()){
        String line = input.nextLine();
        if (line.equals("[TimingPoints]")){
          String[] timingData = input.nextLine().split(",");
          tickInterval = parseInt(timingData[1]);
          BPM = Math.round(60000 / parseFloat(timingData[1]));
          println(tickInterval, BPM);  
          appearanceTime = tickInterval * 2;
          validTime = appearanceTime / 4;
        }
        
        
        if (line.equals("[HitObjects]")){
          
          reached = true;
          continue;
        }
        
        if (reached){
          String[] data = line.split(",");
          
          int[] packed = {64, 0, -1}; //time , type
          packed[0] = Math.round(parseFloat(data[2]));
          if(data[5].substring(0,1).equals("L")){
           packed[1] = 1; 
           packed[2] = parseInt(data[7]);
          }else{
            packed[1] = 0;
          }
          noteReader.addLast(packed);
          
        }
        
        
      }
      
      if (mapSound != null) {
        mapSound.stop();
        mapSound = null;
      }
      
      mapSound = new SoundFile(this, Songscreen.ChosenSong[2]);
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
  volume = amp.analyze();
  
  
  //guard for menu screen
  if (currentTransitionScreen.life > 0){
     currentTransitionScreen.render(); 
     return;
  }
    
  if (gameActive == false){
    if (currentMenu.equals("SongScreen")){
      Songscreen.screenRenderMenu();
      
    }else if (currentMenu.equals("CharScreen")){
      charscreen.screenRenderMenu();
    }else if (currentMenu.equals("TitleScreen")){
      currentTitleScreen.render();
    }
    
    return;
  }else if (gameActive == true && gameSetUpDone == false){
    loadGame();
    gameSetUpDone = true;
  }
  
  musicTime = millis() - startTime;
  
  background(0);
  fill(255);
  
  if (currentPosScore > 9 || currentPosScore < -9 || !mapSound.isPlaying()){
    gameEnd = true;
  }
  
  if (gameEnd){
    if (intermissionTimer < 0){
      cleanUp();
    }
    
    intermissionTimer --;
    textSize(40);
    String winMessage;
    if (currentPosScore == 0){
      winMessage = "Tie!";
    }else if (currentPosScore > 0){
      winMessage = "Player 0 has won by score of "+currentPosScore;
    }else{
      winMessage = "Player 1 has won by score of "+currentPosScore;
    }
    text(winMessage, width/2, height/2); 
    return;
  }
  

   if (noteReader.size() > 0){
    while (noteReader.size() > 0 && noteReader.peekFirst()[0] <= musicTime + appearanceTime){
      int[] data = noteReader.removeFirst();
      
      for (int i = 0; i < players.length; i++){
        players[i].addNote(new Note(i, data[0], data[1], data[2]));
      }
    }
  }
  
  //cameraRender
  currentCamera.renderCamera();
  currentBackground.renderBackground();
  currentDangerScreen.render();
  
  //screenBackground
  textAlign(CENTER);
  for (int i = -2; i < 3; i++){
    int position = currentPosScore + i;
    textSize(abs(position) * 4 + 15);
    text(position, (width/ 10)+ (i + 2)* (width / 5), 800); 
  }
  
  for (int i = 0; i < players.length; i++) {
    players[i].playerCharRender();
    players[i].playerNoteRender();
  }
  
  

}

void keyPressed() {
  if(currentTransitionScreen != null && currentTransitionScreen.life > 0){
    return;
  }
  if (gameActive == false){
    if (currentMenu.equals("TitleScreen")){
      currentMenu = "SongScreen";
      currentTransitionScreen.life = 60;
    }
    
    if (key == 'c'){
      if (currentMenu.equals("SongScreen")){
        currentMenu = "CharScreen";
        currentTransitionScreen.life = 60;
        
      }else if (currentMenu.equals("CharScreen")){
        currentMenu = "SongScreen";
        currentTransitionScreen.life = 60;
      }
      
    }else{
      if (currentMenu.equals("SongScreen")){
        Songscreen.keyPressed();
        
      }else if (currentMenu.equals("CharScreen")){
        charscreen.keyPressed();
      }
      
    }
    return;
  }
  
  if (key == 'q') {
     gameEnd = true;
     return;
  }
  
  for (Player p : players) {
    p.keyPressed();
  }
}
