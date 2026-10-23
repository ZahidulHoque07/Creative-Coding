void setup() {
}

void draw() {
  println(power(2, 0));
  noLoop();
}

float power(float number, int power) {
  float result = 1;
  for (int i = 1; i < power; i++) {
    result *= number;
  }
  
  return result;
}
