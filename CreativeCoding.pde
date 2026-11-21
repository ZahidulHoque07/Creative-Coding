chessBoard board;

String [] lines;
String time;
color lightSquare;
color darkSquare;
int gameNumber;
String playerColour;
int moveCount;

PImage[] pieces;
String[] squares;

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

  loadPieces();

  gameNumber = 1;
  boardUpdate();
}

void draw() {
  background(255);

  board.draw();

  fill(0);
  text("Game: " + gameNumber, 5, 420);
  text("Moves: " + moveCount, 5, 440);

  for (int i = 0; i < pieces.length; i++) {
    drawPiece(squares[i], pieces[i]);
  }
  
  drawPiece("e1", whiteKing);
  drawPiece("e8", blackKing);
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
  generatePieces();
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

int pieceValue(PImage piece) {
  if (piece == whitePawn || piece == blackPawn) {
    return 1;
  } else if (piece == whiteKnight || piece == blackKnight) {
    return 3;
  } else if (piece == whiteBishop || piece == blackBishop) {
    return 3;
  } else if (piece == whiteRook || piece == blackRook) {
    return 5;
  } else if (piece == whiteQueen || piece == blackQueen) {
    return 9;
  }

  return 0;
}

void generatePieces() {
  int remaining = moveCount;

  pieces = new PImage[moveCount];
  squares = new String[moveCount];

  int count = 0;

  while (remaining > 0) {
    int choice = int(random(5));
    PImage piece;

    if (choice == 0) {
      piece = whitePawn;
    } else if (choice == 1) {
      piece = whiteKnight;
    } else if (choice == 2) {
      piece = whiteBishop;
    } else if (choice == 3) {
      piece = whiteRook;
    } else {
      piece = whiteQueen;
    }

    int value = pieceValue(piece);

    if (value <= remaining) {
      pieces[count] = piece;

      String square;

      do {
        char file = (char) int(random(8) + 'a');
        int rank = int(random(8)) + 1;

        square = file + str(rank);
      } while (squareOccupied(square, count));
      squares[count] = square;

      remaining -= value;
      count++;
    }
  }

  PImage[] temp = new PImage[count];

  for (int i = 0; i < count; i++) {
    temp[i] = pieces[i];
  }

  pieces = temp;

  String[] tempSquares = new String[count];

  for (int i = 0; i < count; i++) {
    tempSquares[i] = squares[i];
  }

  squares = tempSquares;
}

boolean squareOccupied(String square, int count) {

  if (square.equals("e1") || square.equals("e8")) {
    return true;
  }

  for (int i = 0; i < count; i++) {
    if (squares[i].equals(square)) {
      return true;
    }
  }

  return false;
}
