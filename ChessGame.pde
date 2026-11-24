class ChessGame {
  String time;
  String playerColour;
  int moveCount;

  PImage[] pieces;
  String[] squares;
  
  ChessGame(String gameTime, String colour, int moves) {
  time = gameTime;
  playerColour = colour;
  moveCount = moves;

  generatePieces();
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

  void display() {
    for (int i = 0; i < pieces.length; i++) {
      drawPiece(squares[i], pieces[i]);
    }

    drawPiece("e1", whiteKing);
    drawPiece("e8", blackKing);
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
}
