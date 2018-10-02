class Player {
  float x;        // x position of player
  float y;        // y position of player
  Coord pos;      // the position of the player in a coordinate

  float targetX, targetY;     // the target of the player, where the player will go next
  float easing;               // easing to make movement look better
  
  PImage sprite;
  
  // constructor that creates a player, starting at a given coordinate
  Player(Coord c) {
    this.x = c.x;
    this.y = c.y;
    targetX = x;
    targetY = y;
    easing = 0.05;
    pos = new Coord(x, y);
    sprite = loadImage("./data/player.png");
  }

  // renders the player using the sprite loaded in the constructor
  void render() {
    imageMode(CENTER);
    sprite.resize(17, 0);
    image(sprite, x, y);
  }

  // moves the player to the target location
  void move() {
    x += (targetX - x) * easing;
    y += (targetY - y) * easing;
    pos.setX(x);
    pos.setY(y);
  }
  
  // sets the target location. used with mousePressed in the main class to allow the
  // user to move with mouse input
  void setTarget(float tx, float ty) {
    this.targetX = tx;
    this.targetY = ty;
  }
  
  // resets the player to a starting position
  void resetPlayer(Coord start) {
    this.x = start.x;
    this.y = start.y;
    this.targetX = start.x;
    this.targetY = start.y;
    pos.setX(start.x);
    pos.setY(start.y);
  }
}