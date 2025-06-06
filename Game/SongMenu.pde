public class SongMenu{
  ArrayList<String[]> ListOfSong = new ArrayList<String[]>(); //"SongName, mapdirectory, musicdirectory"
  int currentIndexSong;
  String[] ChosenSong;
  
  String player1Character = "Char1";
  String player2Character = "Char2";
  
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
      }
    }
    
  }
  
  void screenRenderMenu(){//set up the main menu
    background(0);
    fill(255);
    for (int i = -2; i < 3; i++){
     if(currentIndexSong + i >= 0 && currentIndexSong + i <ListOfSong.size()){
       //display
       fill(255 - (abs(i) * 40));
       textSize(40);
       text(ListOfSong.get(currentIndexSong + i)[0], width / 2, height / 2 + (i * 50)); 
     } 
    }
  }
  
  public SongMenu(){//creation
    compile();
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
      println("Songs/"+ChosenSong[0]+"/map.txt");
    }
    
  }

}
