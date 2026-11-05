chessBoard board;
String [] lines;
String input = "";
String time;
color lightSquare;
color darkSquare;
int gameNumber;

void setup() {
  background(255);
  size(400, 600);
  noStroke();
  lines = loadStrings("Chess.csv");
  textSize(20);
  gameNumber = 1;
  boardUpdate();
}

void draw() {
  board.draw();
  text(gameNumber, 5, 395);
}

void keyPressed() {
  if (keyCode == RIGHT && gameNumber < lines.length - 1) {
    gameNumber++;
  } else if (keyCode == LEFT && gameNumber > 1) {
    gameNumber--;
  }
  boardUpdate();
}

void boardUpdate() {
  String [] tokens = split(lines[gameNumber], ",");
  time = tokens[7];

  if (time.equals("Morning")) {
    lightSquare = color(255, 230, 160);
    darkSquare = color(200, 140, 80);
  } else if (time.equals("Afternoon")) {
    lightSquare = color(220, 240, 255);
    darkSquare = color(80, 140, 200);
  } else {
    lightSquare = color(215, 212, 212);
    darkSquare = color(128, 123, 118);
  }

  board = new chessBoard(lightSquare, darkSquare);
}

void chessClock() {
}
