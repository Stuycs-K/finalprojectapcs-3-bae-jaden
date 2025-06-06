public class CharSelectionScreen{
  ArrayList<String[]> ListOfCharacter = new ArrayList<String[]>(); //"CharName...."

  int player0currentIndex = -1;
  int player1currentIndex = -1;
  
  int player0chosenIndex = -1;
  int player1chosenIndex = -1;
  
  void bind(int playerindex, int charindex){
    if (playerindex == 0){
      if (player0currentIndex != player1chosenIndex){
        println("player " + playerindex + " chose " + ListOfCharacter.get(charindex)[0]);
        player0chosenIndex = charindex;
      }
      
    }else{
      if (player1currentIndex != player0chosenIndex){
        println("player " + playerindex + " chose " + ListOfCharacter.get(charindex)[0]);
        player1chosenIndex = charindex;
      }
    }
  }
  
  void compile(){//setup for songs
    File charactersFolder = new File(dataPath("Characters"));
    File[] characterArray = charactersFolder.listFiles();
    
    for (int charNumber = 0; charNumber < characterArray.length; charNumber ++){
      String[] charInfo = new String[1];
      charInfo[0] = characterArray[charNumber].getName();
      //songInfo[1] = "Songs/"+songInfo[0]+"/map.txt";
      //songInfo[2] = "Songs/"+songInfo[0]+"/audio.mp3";
      ListOfCharacter.add(charInfo);
      
      if (player0currentIndex == -1){
        player0currentIndex = charNumber;
        player0chosenIndex = charNumber;
      }else if(player1currentIndex == -1){
        player1currentIndex = charNumber;
        player1chosenIndex = charNumber;
      }
    }
    
  }
  
  void screenRenderMenu(){//set up the main menu
    background(0);
    textSize(40);
    for (int i = 0; i < ListOfCharacter.size(); i++){
      if (i == player0chosenIndex){
        fill(74, 228, 255);
      }else if (i == player1chosenIndex){
        fill(255, 74, 83);
      }else{
        fill(255);
      }
      text(ListOfCharacter.get(i)[0], width / 2, height / 5 + (i * 50)); 
      
      if (i == player0currentIndex){
        noFill();
        stroke(74, 228, 255);
        rect(width / 2, height / 5 + ((i - 1) * 50), 100,50);
      }else if (i == player1currentIndex){
        noFill();
        stroke(255, 74, 83);
        rect(width / 2, height / 5 + ((i - 1) * 50), 100,50);
      }
      
    }
  }
  
  public CharSelectionScreen(){//creation
    compile();
  }
  
  void keyPressed(){
    if (key == 'a') {
      player0currentIndex = Math.max(0, Math.min(player0currentIndex - 1, ListOfCharacter.size() - 1));
    } else if (key == 'f'){
      player0currentIndex = Math.max(0, Math.min(player0currentIndex + 1, ListOfCharacter.size() - 1));
    } else if (key == 's' || key == 'd'){
      bind(0, player0currentIndex);
    } else if (key == 'k'){
      player1currentIndex = Math.max(0, Math.min(player1currentIndex - 1, ListOfCharacter.size()- 1));
    } else if (key == '\''){
      player1currentIndex = Math.max(0, Math.min(player1currentIndex + 1, ListOfCharacter.size()-1));
    } else if (key == 'l' || key == ';'){
      bind(1, player1currentIndex);
    } else if (key == 'x' && player0chosenIndex != player1chosenIndex){
      println("good to go!");
    }
    
  }
}
