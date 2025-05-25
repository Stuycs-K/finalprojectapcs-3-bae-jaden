public class Note {
  PVector position;
  float radius = 100;
  int lane;
  int time;
  boolean valid = true;
  boolean hit = false;

  public Note(int chosenLane, int player, int x, int y) {
    valid = true;
    lane = chosenLane;
    position = new PVector(x + posOffset * player, y);
  }

  void display() {
    color chosenColor;

    if (lane == 0) {
      chosenColor = color(143, 48, 199);
    } else if (lane == 1) {
      chosenColor = color(48, 181, 199);
    } else if (lane == 2) {
      chosenColor = color(48, 199, 58);
    } else {
      chosenColor = color(199, 48, 53);
    }

    fill(chosenColor);

    if (!hit) {
      stroke(255);
      strokeWeight(12);
      circle(position.x, position.y, radius);
      stroke(0);  
    }
  }

  int returnLane() {
    return lane;
  }

  int returnTime() {
    return time;
  }

  void hit() {
    hit = true;
  }

  boolean returnValid() {
    return valid;
  }
}
