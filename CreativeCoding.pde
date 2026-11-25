ChessGame currentGame;

String [] lines;
int gameNumber;

PImage boardImage;
PImage morningBoard;
PImage afternoonBoard;
PImage eveningBoard;

PImage whitePawn;
PImage whiteKnight;
PImage whiteRook;
PImage whiteBishop;
PImage whiteKing;
PImage whiteQueen;
PImage whiteKingCheckmate;

PImage blackPawn;
PImage blackKnight;
PImage blackRook;
PImage blackBishop;
PImage blackKing;
PImage blackQueen;
PImage blackKingCheckmate;

PImage checkmated;
PImage winner;
PImage timeout;
PImage resigned;


// Chess pieces source: Cburnett chess set, by Colin M. L. Burnett
// Source: https://github.com/lichess-org/lila/tree/master/public/piece/cburnett
// License: GPLv2+

void setup() {
  background(255);
  size(400, 450);
  noStroke();
  lines = loadStrings("Chess.csv");
  textSize(20);

  loadPieces();

  gameNumber = 1;
  boardUpdate();
}

void draw() {
  background(255);
  image(boardImage, 0, 0);
  fill(0);
  text("Game: " + gameNumber, 5, 420);
  text("Moves: " + currentGame.moveCount, 5, 440);
  currentGame.display();
}

void keyPressed() {
  if (keyCode == RIGHT && gameNumber < lines.length - 1) {
    gameNumber++;
  } else if (keyCode == LEFT && gameNumber > 1) {
    gameNumber--;
  }
  boardUpdate();
}

void loadPieces() {
  morningBoard = loadImage("Morning.png");
  afternoonBoard = loadImage("Afternoon.png");
  eveningBoard = loadImage("Evening.png");

  whitePawn = loadImage("White Pawn.png");
  whiteKnight = loadImage("White Knight.png");
  whiteRook = loadImage("White Rook.png");
  whiteBishop = loadImage("White Bishop.png");
  whiteKing = loadImage("White King.png");
  whiteQueen = loadImage("White Queen.png");
  whiteKingCheckmate = loadImage("White King Checkmate.png");


  blackPawn = loadImage("Black Pawn.png");
  blackKnight = loadImage("Black Knight.png");
  blackRook = loadImage("Black Rook.png");
  blackBishop = loadImage("Black Bishop.png");
  blackKing = loadImage("Black King.png");
  blackQueen = loadImage("Black Queen.png");
  blackKingCheckmate = loadImage("Black King Checkmate.png");

  checkmated = loadImage("Checkmated.png");
  winner = loadImage("Winner.png");
  timeout = loadImage("Timeout.png");
  resigned = loadImage("Resigned.png");
}

void boardUpdate() {
  String [] tokens = split(lines[gameNumber], ",");
  currentGame = new ChessGame(tokens[7], tokens[1], int(tokens[8]), tokens[4]);


  if (currentGame.time.equals("Morning")) {
    boardImage = morningBoard;
  } else if (currentGame.time.equals("Afternoon")) {
    boardImage = afternoonBoard;
  } else {
    boardImage = eveningBoard;
  }
}
