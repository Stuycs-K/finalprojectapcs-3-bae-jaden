# Underworld's Beatboxing
*Two player taiko-style arcade game (Local multiplayer)*

Have you ever played pvp rhythm games and was sad that there wasn't any player interactions? It says its pvp but its not really pvp cause all you do is just press the button based on map. The game is not dynamic enough to be considered pvp. Well here is the game for you: inspired by arcade style taiko and fighting game, Underworld's Beatboxing offers dynamic interaction into boring traditional rhythm PVP genre!

## Overview

It is 2025 and the popularity of human musics has spread across the world connecting many individuals. The word of mouth about human musics has reached gloomy underworld and it quickly evolved into showservice fight arena for monsters and demons to enjoy....

Players will play as ghost fighter or demon boxer and fight till one KO's one another. Good reaction speed will help you catch mistake that opponent makes and give a strong punch that will allow you to claim a space. First player to push opponent onto end of stage will KO the opponent and take the victory.

---

## Controls

### Song Selection
- Navigate: `W` / `S`  
- Select Song: `X`  
- Go to Character Menu: `C`  

### Character Selection
- **Player 1**  
  - Move: `A` / `F`  
  - Lock In: `S` / `D`  

- **Player 2**  
  - Move: `K` / `'`  
  - Lock In: `L` / `;`  

- **Back to Song Menu**: `C`  

### In-Game Controls
- **Player 1**  
  - Hit Notes: `S`, `D`  
  - Attack: `F`  

- **Player 2**  
  - Hit Notes: `L`, `;`  
  - Attack: `K`  

---

## Detailed Documentation

### Title screen

When you first play the game, you will be introduced with fancy title screen. You can press any button to continue. 

### Song Picking Menu

In the song selection menu, you can use key W or S to move up and down to chose song you want. Before pressing X to lock the song selection and continute the game, you can press C to move to character selection menu.

### Char Selection Menu

In the Character Selection menu, both players are able to pick their desired fighters. On botth left corner you can see blue border for player one and red border for player two. Player one uses key A or F to move left and right to pick character and S or D to lock in with that character. Player two uses key K or ' to move left and right to pick character and l or ; to lock in with that character.

I added third character to just test out if character selection works as duplicates are prevented, but please do not use the third character as it has placeholder assets. Just pick either first or second character in character picker.

You can exit the character selection menu and move to song selection menu by pressing C again.


### In game

After pressing x to move on to in game, player 1 uses control S or D to hit notes and F to attack. Player 2 uses control l or ; to hit notes and K to attack

On top, you can see the progression for each player to push other opponent, blue bar marks progress for player 1 and red bar marks progress for player 2. 

Normal note will be shown through singular circle without any connections and Long note will be shown through two circle that is connected by stroke. During long note, players can spam their hit buttons.

When any players miss or gets "bad" rating on their hitting notes, they become "vulnerable" status, meaning other player can use attack to capture one space. 

However, when player tries to attack when opponent is not "vulnerable", player themselves will fail to attack and become vulnerable themselves.

Below, the current position is marked with numbered index that changes each time player successfully attacks. The game ends when the song finishes, or the position becomes -10 or 10 (KO).

The game will tie if the position is 0 meaning both players captured equal amount of space. Otherwise, at the end of song, player who were able to push opponent further wins.

As the game plays out, if both players continue to hit notes in "perfect" rating and does not miss, camera will zoom in. This is released when either one attacks succeed or one misses / hits bad. 

### Win Screen

Win message is displayed and the screen will go back to song picking menu.

---

## Credits

Game concept / development by **OPM games** 

Music used are property of their respective owners.
Assets belong to **OPM games**