chessBoard board;
String [] lines;
String input = "";
String time;
color lightSquare;
color darkSquare;
int gameNumber;
boolean submitted = false;

void setup() {
  size(400, 400);
  noStroke();
  lines = loadStrings("Chess.csv");
  textSize(20);
}

void draw() {
  background(255);

  if (submitted == true) {
    board.draw();
  } else {
    fill(0);
    text("Enter game number:", 30, 50);
    text(input, 30, 90);
  }
}

void keyPressed() {
  if (key >= '0' && key <= '9') {
    input += key;
  } else if (key == BACKSPACE && input.length() > 0) {
    input = input.substring(0, input.length() - 1);
  } else if (key == ENTER || key == RETURN) {
    if (input.length() > 0) {
      gameNumber = int(input);

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

      submitted = true;
    }
  }
}
