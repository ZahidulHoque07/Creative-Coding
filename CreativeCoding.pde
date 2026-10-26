chessBoard board;
color lightSquare;
color darkSquare;
void setup() {
  size(400, 400);

  String[] lines = loadStrings("Chess.csv");
  String [] tokens = split(lines[5], ",");
  String time = tokens[7]; // Replace 3 with your column index
  println(tokens[7]);

  noStroke();

  if (time.equals("Morning")) {
    lightSquare = color(255, 230, 160);
    darkSquare = color(200, 140, 80);
  } else if (time.equals("Afternoon")) {
    lightSquare = color(220, 240, 255);
    darkSquare = color(80, 140, 200);
  } else {
    lightSquare = color(255);
    darkSquare = color(0);
  }
  board = new chessBoard(lightSquare, darkSquare);
}

void draw() {
  board.draw();
}
