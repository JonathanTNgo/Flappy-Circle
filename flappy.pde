final int max = 30;
final int jumpEaseLimit = 4;
final int jumpAmount = 80;
final float accelConstant = 1.3;
final float deccelConstant = 1.5;
final int groundY = displayHeight;
final int wallSpeed = 4;
final int ballRadius = displayWidth / 25;
final int screenChunks = 10;
final int barrierWidth = displayWidth / screenChunks;
final int barrierCooldownMax = 100;

boolean restart = true;
boolean gameOver = true;
boolean accel = true;
boolean jump = false;
int jumpEaseCount = 0;
int jumpEaseDy;
int gapSize = 5;
float dy = 1;
float x = 500;
float y = 250;
int xWidth = displayWidth / screenChunks;
List barriers = new List();
int barrierCooldown = 0;

void setup() {
  background(250, 250, 250);
  frameRate(30);
  fullScreen();
}


void draw() {
  if (gameOver) {
    restart = true;
    background(0);
    fill(250, 250, 250);
    
    // Game over text
    textSize(30);
    textAlign(CENTER);
    text("Press Space to start", displayWidth / 2, displayHeight / 2);
    text("Rules: Space to jump and don't hit the walls and edges", displayWidth / 2, displayHeight / 3);
  } else if (restart) {
    barriers = new List();
    x = 500;
    y = 250;
    accel = true;
    jump = false;
    jumpEaseCount = 0;
    barrierCooldown = 0;
    dy = 1;
    restart = false;
  } else {
    // Setup background
    fill(0);
    background(250, 250, 250);

    // Draw wall
    handleWalls();

    //// Ball and ball velocity
    ellipse(x, y, displayWidth / 25, displayWidth / 25);
    ballPositionAndVelocity();
    
    // Print framerate
    textSize(30);
    text(frameRate, 50, groundY + 50);
  }
}


void handleCollisions(Barrier curr) {
  int ballBuffer = (displayWidth / 25) /2;
  if (x + ballBuffer >= curr.topX && x - ballBuffer <= curr.topX + displayWidth / screenChunks) {
    if (y - ballBuffer <= curr.topY || y + ballBuffer >= curr.botY) {
      gameOver = true;
    }
  }
}

void handleWalls() {
  if (barrierCooldown < 1) {
    // spawn a barrier
    // Barrier should be (barrierWidth, ballR * 3, wallSpeed), but finals aren't working
    barriers.add(new Node( new Barrier (displayWidth / 10, (displayWidth / 25) * gapSize, wallSpeed)));
    barrierCooldown = barrierCooldownMax;
  }
  
  // Update barriers
  Node current = barriers.header.next;
  while (current != null) {
    
    // Delete barrier if it is outside of screen
    if (current.value.topX + (displayWidth / screenChunks) < 0) {
      barriers.pop();
    }
    
    handleCollisions(current.value);
    current.value.update();
    current = current.next;
  }
  
  barrierCooldown--;
}

void ballPositionAndVelocity() {
  if (jump) {
    accel = false;
    jumpEaseCount++;

    // Eases the jump through a counter
    if (jumpEaseCount < jumpEaseLimit) {
      y -= jumpAmount /  jumpEaseLimit;
    } else {
      jump = false;
    }
  } else if (accel) {
    // increasing dy and ensuring dy <= 75
    dy = (dy * accelConstant >= max) ? max : dy * accelConstant;

    // Game overs upon touching bottom of screen
    if (y >= (displayHeight - (displayWidth / 25)) || y < (0 + (displayWidth / 25))) {
      accel = false;
      gameOver = true;
    } else {
      y += dy;
    }
    // Decelerating (going up)
  } else {
    dy = (dy / deccelConstant <= 1) ? 1 : dy / deccelConstant;

    if (dy == 1) {
      accel = true;
    }
    y -= dy;
  }
}


void keyPressed() {
  if (key == ' ') {
    jump = true;
    jumpEaseCount = 0;
    
    if (gameOver) {
      gameOver = false;
    }
  }
}
