class Guard {
  float x;                  // the x coordinate of the guard
  float y;                  // the y coordinate of the guard
  Coord start;              // the starting position of the guard. constant
  Coord end;                // the end position of the guard. constant

  int dist;                 // how far ahead the guard can see. depends on difficulty
  
  boolean toStart;          // true if the guard is heading to the start location
  boolean toEnd;            // true if the guard is heading to the end location
  float easing = 0.05;      // easing to make movement look better
  
  // create psuedo-animation using three different pictures of the drone with
  //   the blades in different positions
  PImage sprite1;
  PImage sprite2;
  PImage sprite3;

  // constructor creates a guard with a certain level of difficulty
  Guard(String diff) {
    // places the guards starting location at a certain position
    this.x = random(50, width - 50);
    this.y = random(50, height - 50);
    this.start = new Coord(x, y);
    
    // loads images
    sprite1 = loadImage("./data/drone1.png");
    sprite2 = loadImage("./data/drone2.png");
    sprite3 = loadImage("./data/drone3.png");
    
    // sets the guard to go towards the end location first
    this.toStart = false;
    this.toEnd = true;
    
    // sets up the seeing radius and end location depending on difficulty
    if (diff == "easy") {
      this.dist = 30;
      this.end = makeRandomCoord(100);
    }
    else if (diff == "medium") {
      this.dist = 60;
      this.end = makeRandomCoord(150);
    }
    else {
      this.dist = 90;
      this.end = makeRandomCoord(300);
    }
  }

  // draws the drone
  void render() {
    // view area of drone
    ellipseMode(CENTER);
    fill(255, 255, 0, 50);
    stroke(255, 255, 0);
    ellipse(x, y, dist*2, dist*2);
    
    // load images depending on the frame
    if (frameCount % 3 == 0) {
      imageMode(CENTER);
      sprite1.resize(50, 0);
      image(sprite1, x, y);
    }
    if (frameCount % 3 == 1) {
      imageMode(CENTER);
      sprite2.resize(50, 0);
      image(sprite2, x, y);
    }
    if (frameCount % 3 == 2) {
      imageMode(CENTER);
      sprite3.resize(50, 0);
      image(sprite3, x, y);
    }
  }
  
  // moves the guard to a specific coordinate
  void moveGuard(Coord c) {
    this.x = c.x;
    this.y = c.y;
  }

  // moves the guard towards its destination
  void move() {
    // moves the guard to the end location
    if (toEnd) {
      x += (end.x - x) * easing;
      y += (end.y - y) * easing;
      
      float dx = end.x - x;
      float dy = end.y - y;
      
      if (abs(dx) < 1 && abs(dy) < 1) {
        x = end.x;
        y = end.y;
        toStart = true;
        toEnd = false;
      }
    }
    
    // moves the guard to the start location
    if (toStart) {
      x += (start.x - x) * easing;
      y += (start.y - y) * easing;
      
      float dx = start.x - x;
      float dy = start.y - y;
      
      if (abs(dx) < 1 && abs(dy) < 1) {
        x = start.x;
        y = start.y;
        toEnd = true;
        toStart = false;
      }
    }
  }

  // checks to see if the guard sees a specific position using the distance formula
  boolean guardSeesPlayer(Coord pos) {
    if (sqrt(pow(pos.x - x, 2) + pow(pos.y - y, 2)) <= dist) {
      return true;
    } else {
      return false;
    }
  }
  
  // creates a random coord for the end location of the drone
  Coord makeRandomCoord(int delta) {
    float startX = start.x;
    float startY = start.y;
    
    int deltaX = (int) random(delta - 100, delta + 100);
    int deltaY = (int) random(delta - 100, delta + 100);
    
    Coord e;
    
    if (startX + deltaX >= width || startX + deltaX <= 0 || 
        startY + deltaY >= height || startY + deltaY <= 0) {
      e = makeRandomCoord(delta);
    }
    
    e = new Coord (startX + deltaX, startY + deltaY);
    return e;
  }
}