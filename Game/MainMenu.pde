public class MainMenu{
  ArrayList<String[]> ListOfSong; //"SongName, Difficulty"
  int currentIndexSong;
  
  void compile(){//setup for songs
  
  }
  
  void screenRenderMenu(){//set up the main menu
  
  }
  
  public MainMenu(){//creation
    
  
  }
  
  void keyPressed(){
    if (key == 'w') {
      currentIndexSong --;
    } else if (key == 's'){
      currentIndexSong ++;
    } 
  
  }

}
