public class CharSelectionScreen{
  ArrayList<String[]> ListOfCharacter = new ArrayList<String[]>(); //"CharName...."
  ArrayList<PImage> ListOfIcon = new ArrayList<PImage>();
  
  PImage background, rope;
  PImage pl0Image, pl1Image;
  
  int player0currentIndex = -1;
  int player1currentIndex = -1;
  
  int player0chosenIndex = -1;
  int player1chosenIndex = -1;
  
  float smoothedAdjustment = 1.0;
  float smoothedAdjustment1 = 1.0;
  
  String player0Character = "Char1";
  String player1Character = "Char2";
  
  void bind(int playerindex, int charindex){
    if (playerindex == 0){
      if (player0currentIndex != player1chosenIndex){
        println("player " + playerindex + " chose " + ListOfCharacter.get(charindex)[0]);
        player0chosenIndex = charindex;
        println("Selected Character: " + ListOfCharacter.get(charindex));
        player0Character = ListOfCharacter.get(charindex)[0];
        setImage(ListOfCharacter.get(charindex)[0], 0);
      }
      
    }else{
      if (player1currentIndex != player0chosenIndex){
        println("player " + playerindex + " chose " + ListOfCharacter.get(charindex)[0]);
        player1chosenIndex = charindex;
        println(ListOfCharacter.get(charindex)[0]);
        player1Character = ListOfCharacter.get(charindex)[0];
        setImage(ListOfCharacter.get(charindex)[0], 1);
      }
    }
  }
  
  void setImage(String name, int player){
   if (player == 0){
     pl0Image = loadImage("Characters/" + name + "/Closeup.png");
     
   }else{
     pl1Image = loadImage("Characters/" + name + "/Far.png");
   
   } 
  }
  
  void compile(){//setup for songs
    File charactersFolder = new File(dataPath("Characters"));
    File[] characterArray = charactersFolder.listFiles();
    
    for (int charNumber = 0; charNumber < characterArray.length; charNumber ++){
      String[] charInfo = new String[1];
      charInfo[0] = characterArray[charNumber].getName();
      ListOfCharacter.add(charInfo);
      File iconFile = new File(characterArray[charNumber], "Icon.png");
      ListOfIcon.add(loadImage(iconFile.getAbsolutePath()));
      
      if (player0currentIndex == -1){
        player0currentIndex = charNumber;
        player0chosenIndex = charNumber;
        setImage(charInfo[0], 0);
      }else if(player1currentIndex == -1){
        player1currentIndex = charNumber;
        player1chosenIndex = charNumber;
        setImage(charInfo[0], 1);
      }
    }
    
  }
  
  void screenRenderMenu(){//set up the main menu
    strokeWeight(1);
  
    float adjustment = (volume / 12) + 1;
    smoothedAdjustment = lerp(smoothedAdjustment, adjustment, 0.2);
    
    smoothedAdjustment1 = lerp(smoothedAdjustment1, adjustment, 0.1);
    
    background(0);
    fill(255);
    
    imageMode(CENTER);
    rectMode(CENTER);  
  
    image(background, width / 2, height / 2, smoothedAdjustment1 * background.width, smoothedAdjustment1 * background.height);
    image(pl1Image, width / 2, height / 2, smoothedAdjustment1 * pl1Image.width , smoothedAdjustment1 * pl1Image.height);
    image(pl0Image, width / 2, height / 2, smoothedAdjustment1 * pl0Image.width, smoothedAdjustment1 * pl0Image.height);
    
    image(rope, width / 2, height / 2, smoothedAdjustment * rope.width , smoothedAdjustment * rope.height);
    
    
    
    textSize(40);
    for (int i = 0; i < ListOfCharacter.size(); i++){
      if (i == player0chosenIndex){
        fill(74, 228, 255);
      }else if (i == player1chosenIndex){
        fill(255, 74, 83);
      }else{
        fill(255);
      }
      image(ListOfIcon.get(i),150 + (i * 150), 900);
      
      if (i == player0currentIndex){
        noFill();
        stroke(74, 228, 255);
        rect(150 + (i * 150), 900, ListOfIcon.get(i).width,ListOfIcon.get(i).height);
      }else if (i == player1currentIndex){
        noFill();
        stroke(255, 74, 83);
        rect(150 + (i * 150), 900, ListOfIcon.get(i).width,ListOfIcon.get(i).height);
      }
      
    }
  }
  
  public CharSelectionScreen(){//creation
    background = loadImage("Assets/CharMenu/Background.png");
    rope = loadImage("Assets/CharMenu/Rope.png");
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
