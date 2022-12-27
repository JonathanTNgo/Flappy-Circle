class Barrier {
  
  int barrierWidth;
  int topX;
  int topY;
  int botY;
  int gapSize;
  int speed;
  
  Barrier (int barrierWidth, int gapSize, int speed) {
    this.speed = speed;
    this.gapSize = gapSize;
    this.barrierWidth = barrierWidth;
    this.topX = displayWidth;
    
    // Creating the top/botttom barriers
    int chunkSplit = displayHeight / 10;
    int middle = (int) random(chunkSplit * 1.5, displayHeight - chunkSplit);
    // End Y of top barrier half
    topY = middle - (gapSize / 2);
    // Start Y of bottom barrier half
    botY = middle + (gapSize / 2);
  }
  
  void update() {
    topX = topX - speed;
    rect(topX, 0, barrierWidth, topY);
    rect(topX, botY, barrierWidth, displayHeight);
  }
}
