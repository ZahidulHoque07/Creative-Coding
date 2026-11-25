class ChessGame {
  String time;
  String playerColour;
  int moveCount;
  String result;

  PImage[] pieces;
  String[] squares;

  ChessGame(String gameTime, String colour, int moves, String gameResult) {
    time = gameTime;
    playerColour = colour;
    moveCount = moves;
    result = gameResult;

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

        String square ="";

        boolean occupied = true;

        while (occupied) {
          char file = (char) int(random(8) + 'a');
          int rank = int(random(8)) + 1;

          square = file + str(rank);

          occupied = squareOccupied(square, count);
        }

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

  void drawPiece(String square, PImage piece, int offsetX, int offsetY, int w, int h) {
    int col = square.charAt(0) - 'a';
    int row = 8 - Character.getNumericValue(square.charAt(1));

    if (playerColour.equals("black")) {
      col = 7 - col;
      row = 7 - row;
    }

    float x = col * 50;
    float y = row * 50;

    image(piece, x + offsetX, y + offsetY, w, h);
  }

  void display() {
    for (int i = 0; i < pieces.length; i++) {
      drawPiece(squares[i], pieces[i], 0, 0, 50, 50);
    }
    gameResult();
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

  void gameResult() {
    boolean whiteCheckmated =
      (result.equals("checkmated") && playerColour.equals("white")) ||
      (result.equals("win (checkmate)") && playerColour.equals("black"));

    boolean blackCheckmated =
      (result.equals("checkmated") && playerColour.equals("black")) ||
      (result.equals("win (checkmate)") && playerColour.equals("white"));

    drawPiece("e1", whiteCheckmated ? whiteKingCheckmate : whiteKing, 0, 0, 50, 50);
    drawPiece("e8", blackCheckmated ? blackKingCheckmate : blackKing, 0, 0, 50, 50);

    if (whiteCheckmated) {
      drawPiece("e1", checkmated, 35, -5, 20, 20);
      drawPiece("e8", winner, 35, -5, 20, 20);
    }

    if (blackCheckmated) {
      drawPiece("e8", checkmated, 35, -5, 20, 20);
      drawPiece("e1", winner, 35, -5, 20, 20);
    }

    boolean whiteLost =
      (result.equals("checkmated") && playerColour.equals("white")) ||
      (result.equals("resigned") && playerColour.equals("white")) ||
      (result.equals("timeout") && playerColour.equals("white")) ||
      (result.equals("win (checkmate)") && playerColour.equals("black")) ||
      (result.equals("win (resignation)") && playerColour.equals("black")) ||
      (result.equals("win (timeout)") && playerColour.equals("black"));

    boolean blackLost =
      (result.equals("checkmated") && playerColour.equals("black")) ||
      (result.equals("resigned") && playerColour.equals("black")) ||
      (result.equals("timeout") && playerColour.equals("black")) ||
      (result.equals("win (checkmate)") && playerColour.equals("white")) ||
      (result.equals("win (resignation)") && playerColour.equals("white")) ||
      (result.equals("win (timeout)") && playerColour.equals("white"));

    if (whiteLost) {
      if (result.equals("checkmated") || result.equals("win (checkmate)")) {
        drawPiece("e1", checkmated, 35, -5, 20, 20);
      } else if (result.equals("resigned") || result.equals("win (resignation)")) {
        drawPiece("e1", resigned, 35, -5, 20, 20);
      } else if (result.equals("timeout") || result.equals("win (timeout)")) {
        drawPiece("e1", timeout, 35, -5, 20, 20);
      }

      drawPiece("e8", winner, 35, -5, 20, 20);
    }

    if (blackLost) {
      if (result.equals("checkmated") || result.equals("win (checkmate)")) {
        drawPiece("e8", checkmated, 35, -5, 20, 20);
      } else if (result.equals("resigned") || result.equals("win (resignation)")) {
        drawPiece("e8", resigned, 35, -5, 20, 20);
      } else if (result.equals("timeout") || result.equals("win (timeout)")) {
        drawPiece("e8", timeout, 35, -5, 20, 20);
      }

      drawPiece("e1", winner, 35, -5, 20, 20);
    }
  }
}
