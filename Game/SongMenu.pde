public class SongMenu{
  ArrayList<String[]> ListOfSong = new ArrayList<String[]>(); //"SongName, mapdirectory, musicdirectory"
  int currentIndexSong;
  String[] ChosenSong;
  
  String player1Character = "Char1";
  String player2Character = "Char2";
  
  PImage background, Screen, Frame, Gargoyle;
  
  float smoothedAdjustment = 1.0;
  float smoothedAdjustment1 = 1.0;
  
  PApplet parent;
  
  public SongMenu(PApplet p){//creation
    parent = p;
    
    background = parent.loadImage("Assets/SongMenu/Background.png");
    Screen = parent.loadImage("Assets/SongMenu/Screen.png");
    Frame = parent.loadImage("Assets/SongMenu/Frame.png");
    Gargoyle = parent.loadImage("Assets/SongMenu/Gargoyle.png");
    compile();
  }
  
  void compile(){//setup for songs
    File songFolder = new File(dataPath("Songs"));
    File[] songArray = songFolder.listFiles();
    
    for (int songNumber = 0; songNumber < songArray.length; songNumber ++){
      String[] songInfo = new String[3];
      songInfo[0] = songArray[songNumber].getName();
      songInfo[1] = "Songs/"+songInfo[0]+"/map.txt";
      songInfo[2] = "Songs/"+songInfo[0]+"/audio.mp3";
      ListOfSong.add(songInfo);
      
      if (ChosenSong == null){
        ChosenSong = songInfo;
        pickNewSong(songInfo);
      }
    }
    
  }
  
  void pickNewSong(String[] songInfo) {
    if (mapSound != null) {
      mapSound.stop();
      mapSound = null;
    }
    
    if (parent != null) {
      mapSound = new SoundFile(parent, songInfo[2]);
      mapSound.play();
      if(amp != null){
        amp.input(mapSound);
      }
      
    }
  }
  
  void screenRenderMenu(){//set up the main menu
  
    float adjustment = (volume / 4) + 1;
    smoothedAdjustment = lerp(smoothedAdjustment, adjustment, 0.2);
    
    smoothedAdjustment1 = lerp(smoothedAdjustment1, adjustment, 0.1);
    
    background(0);
    fill(255);
    image(background, width / 2, height / 2, smoothedAdjustment1 * background.width * 1.1, smoothedAdjustment1 * background.height * 1.1);
    image(Screen, width / 2, height / 2, smoothedAdjustment1 * Screen.width , smoothedAdjustment1 * Screen.height);
    image(Frame, width / 2, height / 2, smoothedAdjustment1 * Frame.width, smoothedAdjustment1 * Frame.height);
    image(Gargoyle, 400, 270, smoothedAdjustment * Gargoyle.width * 0.8, smoothedAdjustment * Gargoyle.height * 0.8);
    
    for (int i = -2; i < 3; i++){
     if(currentIndexSong + i >= 0 && currentIndexSong + i <ListOfSong.size()){
       //display
       fill(255 - (abs(i) * 40));
       text(ListOfSong.get(currentIndexSong + i)[0], 600, height / 2 + (i * 50)); 
     } 
    }
  }
  
  
  
  void keyPressed(){
    if (key == 'w') {
      currentIndexSong = Math.max(0, Math.min(currentIndexSong - 1, ListOfSong.size()));
    } else if (key == 's'){
      currentIndexSong = Math.max(0, Math.min(currentIndexSong + 1, ListOfSong.size()));
    } else if (key == 'x' && ChosenSong != null){
      currentTransitionScreen.life = 60;
      gameActive = true;      
    }
    
    if (currentIndexSong >= 0 && currentIndexSong < ListOfSong.size()){
      ChosenSong = ListOfSong.get(currentIndexSong);
      pickNewSong(ChosenSong);
      println("Songs/"+ChosenSong[0]+"/map.txt");
    }
    
  }

}
