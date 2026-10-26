class chessBoard {
  color lightSquare;
  color darkSquare;

  chessBoard(color light, color dark) {
    lightSquare = light;
    darkSquare = dark;
  }

  void draw() {
    int squareSize = 50;

    for (int row = 0; row < 8; row++) {
      for (int col = 0; col < 8; col++) {
        if ((row + col) % 2 == 0) {
          fill(lightSquare);
        } else {
          fill(darkSquare);
        }

        rect(col * squareSize, row * squareSize, squareSize, squareSize);
      }
    }
  }
}
