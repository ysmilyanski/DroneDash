class Level {
  Player player;    // the player in the level
  int numGuards;    // # of guards in the level
  Guard[] guards;   // the guard(s) in the level
  Coord start;      // the starting point of the player
  Coord end;        // where the player needs to end up to beat the level
  boolean playerCaught;    // true if the player has been caught
  boolean playerWin;       // true if the player wins
  int numberOfFails;       // number of times the player has been caught by a drone
  int diff;                // the difficulty of the level as a number. 
                           //    higher the number, the more difficult the level
  float points;            // number of points won by player
  int ticksSinceStart;     // AKA frameCount
  PImage startPortal;      // start portal image
  PImage endPortal;        // end portal image

  // constructor that makes level with certain difficulty
  Level(int diff) {
    // set start and end point for level
    start = new Coord((int)random(0, width), (int)random(0, height));
    end = new Coord((int)random(0, width), (int)random(0, height));

    // create player and guards 
    this.player = new Player(start);
    
    // creates guards depending on difficulty
    if (diff <= 5) {
      numGuards = diff;
      this.guards = new Guard[numGuards];
      for (int i = 0; i < guards.length; i++) {
        guards[i] = new Guard("easy");
      }
    } else if (diff > 5 && diff <= 10) {
      numGuards = diff - 4;
      this.guards = new Guard[numGuards];
      for (int i = 0; i < guards.length; i++) {
        guards[i] = new Guard("medium");
      }
    } else {
      numGuards = diff - 9;
      this.guards = new Guard[numGuards];
      for (int i = 0; i < guards.length; i++) {
        guards[i] = new Guard("hard");
      }
    }
    
    // load portal images
    startPortal = loadImage("./data/startPortal.png");
    endPortal = loadImage("./data/endPortal.png");

    // set beginning values for game
    playerCaught = false;
    playerWin = false;
    numberOfFails = 0;
    this.diff = diff;
    this.points = 0;
    ticksSinceStart = 0;
  }

  // draw the level
  void render() {
    start.render(startPortal);
    end.render(endPortal);
    player.render();
    for (int i = 0; i < guards.length; i++) {
      guards[i].render();
    }
  }

  // move the level and also check if the player has been caught or has won
  void move() {
    ticksSinceStart++;

    player.move();
    for (int i = 0; i < guards.length; i++) {
      guards[i].move();
    }

    // checks to see if the player has been caught by one of the guards or has one
    playerInSight();
    playerWon();

    // if the player has won
    if (playerWin) {
      calcPoints();
    }

    // if the player has been caught by a guard, reset the position, and +1 to number of fails of level
    if (playerCaught) {
      player.resetPlayer(start);
      numberOfFails++;
      playerCaught = false;
    }
  }

  // checks to see if the player has been caught by one of the guards
  void playerInSight() {
    if (player.pos.x != start.x && player.pos.y != start.y) {
      for (int i = 0; i < guards.length; i++) {
        if (guards[i].guardSeesPlayer(player.pos)) {
          playerCaught = true;
          println("player caught!");
        }
      }
    }
  }

  // checks to see if the player has won by reaching the end portal
  void playerWon() {
    if (player.pos.x >= end.x - 20 &&
      player.pos.x <= end.x + 20 &&
      player.pos.y >= end.y - 20 
      && player.pos.y <= end.y + 20) {
      playerWin = true;
    }
  }

  // calculates the points earned by the player after the level has been won
  // points = [distance between start and end portal * 10] - how much time has passed 
  //           - number of fails of the level
  void calcPoints() {
    float distStartAndEnd = sqrt(pow(start.x - end.x, 2) + pow(start.y - end.y, 2));
    this.points = (distStartAndEnd * 10) - ticksSinceStart - numberOfFails;
  }
}