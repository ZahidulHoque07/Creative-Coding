chessBoard board;

String [] lines;
String time;
color lightSquare;
color darkSquare;
int gameNumber;
String playerColour;
int moveCount;

PImage whitePawn;
PImage whiteKnight;
PImage whiteRook;
PImage whiteBishop;
PImage whiteKing;
PImage whiteQueen;

PImage blackPawn;
PImage blackKnight;
PImage blackRook;
PImage blackBishop;
PImage blackKing;
PImage blackQueen;

// images source: https://www.chess.com/

void setup() {
  background(255);
  size(400, 450);
  noStroke();
  lines = loadStrings("Chess.csv");
  textSize(20);

  whitePawn = loadImage("White Pawn.png");
  whiteKnight = loadImage("White Knight.png");
  whiteRook = loadImage("White Rook.png");
  whiteBishop = loadImage("White Bishop.png");
  whiteKing = loadImage("White King.png");
  whiteQueen = loadImage("White Queen.png");

  blackPawn = loadImage("Black Pawn.png");
  blackKnight = loadImage("Black Knight.png");
  blackRook = loadImage("Black Rook.png");
  blackBishop = loadImage("Black Bishop.png");
  blackKing = loadImage("Black King.png");
  blackQueen = loadImage("Black Queen.png");

  gameNumber = 1;
  boardUpdate();
}

void draw() {
  background(255);
  board.draw();
  fill(0);
  text("Game: " + gameNumber, 5, 420);
  text("Moves: " + moveCount, 5, 440);
  drawPiece("a2", whitePawn);
  drawPiece("b2", whitePawn);
  drawPiece("c2", whitePawn);
  drawPiece("d2", whitePawn);
  drawPiece("e2", whitePawn);
  drawPiece("f2", whitePawn);
  drawPiece("g2", whitePawn);
  drawPiece("h2", whitePawn);

  drawPiece("e1", whiteKing);
  drawPiece("d1", whiteQueen);
  drawPiece("a1", whiteRook);
  drawPiece("h1", whiteRook);
  drawPiece("b1", whiteKnight);
  drawPiece("g1", whiteKnight);
  drawPiece("c1", whiteBishop);
  drawPiece("f1", whiteBishop);

  drawPiece("a7", blackPawn);
  drawPiece("b7", blackPawn);
  drawPiece("c7", blackPawn);
  drawPiece("d7", blackPawn);
  drawPiece("e7", blackPawn);
  drawPiece("f7", blackPawn);
  drawPiece("g7", blackPawn);
  drawPiece("h7", blackPawn);

  drawPiece("e8", blackKing);
  drawPiece("d8", blackQueen);
  drawPiece("a8", blackRook);
  drawPiece("h8", blackRook);
  drawPiece("b8", blackKnight);
  drawPiece("g8", blackKnight);
  drawPiece("c8", blackBishop);
  drawPiece("f8", blackBishop);

  println(playerColour);
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
  playerColour = tokens[1];
  moveCount = int(tokens[8]);

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

void drawPiece(String square, PImage piece) {
  int col = square.charAt(0) - 'a';
  int row = 8 - Character.getNumericValue(square.charAt(1));

  if (playerColour.equals("black")) {
    col = 7 - col;
    row = 7 - row;
  }

  float x = col * 50;
  float y = row * 50;

  image(piece, x, y, 50, 50);
}
