/**
  * Perlin Snake (s)
  *
  * Serpentine motion using Perlin Noise.
  *
  * @author      Martin Latter <copysense.co.uk>
  * @copyright   Martin Latter 18/04/2010
  * @license     The MIT License (MIT)
  * @link        https://github.com/Tinram/Perlin-Snake.git
*/


int iNumSnakeSegments = 300;
int iSnakeTypeVal = 1000;
boolean bSnakeType = false;
Segment[] aGreenSnake = new Segment[iNumSnakeSegments];
Segment[] aRedSnake = new Segment[iNumSnakeSegments];


void setup() {

  size(500, 500);
  background(0);
  colorMode(HSB);
  noStroke();
  smooth();

  for (int i = 0; i < iNumSnakeSegments; i++) {
    aGreenSnake[i] = new Segment(false);
    aRedSnake[i] = new Segment(true);
  }
}


void draw() {

  background(0);

  for (int i = 0; i < iNumSnakeSegments; i++) {
    aGreenSnake[i].move();
    aRedSnake[i].move();
  }
}


class Segment {

  float fXp, fYp, fNoise, fR, fOffset;
  float fCx = width * 0.5;
  float fCy = height * 0.5;
  float fIncrement = 0.01; // noise increment
  int iSegmentColor = 85;
  color cCol;

  Segment(boolean bSnakeRed) {

    if (bSnakeRed) {
      this.iSegmentColor = 0;
      this.fCx = 0.2;
      this.fCy = 0.3;
      this.fIncrement = 0.02;
    }
    this.fOffset = random(1);
    this.cCol = (random(1) > 0.5)? color(0, 0, random(25, 40)) : color(iSegmentColor, random(170, 210), random(120, 180)); // grey or green segment
  }

  void move() {

    this.fNoise = noise(this.fOffset) * iSnakeTypeVal;
    this.fR = noise(this.fOffset) * 10;
    this.fOffset += this.fIncrement;
    this.fXp = (cos(radians(this.fNoise)) * this.fR) + this.fCx;
    this.fYp = (sin(radians(this.fNoise)) * this.fR) + this.fCy;

    if (mousePressed) { // reset all particle origins to mouse position
      this.fXp = mouseX;
      this.fYp = mouseY;
    }

    if (this.fXp < 5) {
      this.fXp = 5;
    }

    if (this.fXp > width - 5) {
      this.fXp = width - 5;
    }

    if (this.fYp < 5) {
      this.fYp = 5;
    }

    if (this.fYp > height - 5) {
      this.fYp = height - 5;
    }

    fill(this.cCol);
    ellipse(this.fXp, this.fYp, 7, 7);

    this.fCx = this.fXp;
    this.fCy = this.fYp;
  }
}


void keyPressed() {

  if (key == 't') {
    bSnakeType = !bSnakeType;
    iSnakeTypeVal = (bSnakeType) ? 10000 : 1000;
  }
}
