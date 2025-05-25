int posOffset;
char[] keys1 = {'a', 's', 'k', 'l'};
char[] keys2 = {'x', 'z', ';', '\''};
int yCurrent;
int tick;

Player[] players = {new Player(0, keys1), new Player(1, keys2)}; 

void setup() {
  size(1920, 1080);
  posOffset = (width / 2);
  tick = 0;
}

void draw() {
  background(0);
  fill(255);

  yCurrent += 5;
  if (yCurrent > height) {
    yCurrent = 0;
  }

  if (tick % 30 == 0) {
    for (int i = 0; i < players.length; i++) {
      int lane = (int)(Math.random() * 4);
      players[i].addNote(new Note(lane, i, (lane * 100 + 100), yCurrent));
    }
  }

  for (int i = 0; i < players.length; i++) {
    players[i].playerScreenRender();
  }

  tick++;
}

void keyPressed() {
  for (Player p : players) {
    p.keyPressed();
  }
}
