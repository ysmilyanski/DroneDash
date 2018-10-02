class Game {
  ArrayList<Level> levels;      // all the levels of the game
  float totalPoints;            // total points for the game
  float pointsTilNow;           // points of all levels before the 
                                //   current one being played
  Level currentLevel;           // the current level being played
  
  PFont font;                   // holds the font
  PImage splashScreen;          // holds the splashscreen image
  boolean splashScreenMode;     // true if game is in splash screen mode
  PImage instructions;          // holds the instructions image
  boolean instructionsMode;     // true if game is in instructions mode

  // constructs a game!
  Game() {
    totalPoints = 0;
    pointsTilNow = 0;
    levels = new ArrayList<Level>();
    levels.add(new Level(1));
    currentLevel = levels.get(0);

    font = createFont("SilomBol.ttf", 32);
    textFont(font);
    splashScreen = loadImage("./data/splashscreen.jpg");
    splashScreenMode = true;
    instructions = loadImage("./data/instructions.jpg");
    instructionsMode = false;
  }

  // adds a level with +1 difficulty to the last one only if the player has
  // won the current level
  void addLevel() {
    if (currentLevel.playerWin) {
      calcPoints();
      int prevLevel = levels.size() - 1;
      int prevLevelDiff = levels.get(prevLevel).diff;
      levels.add(new Level(prevLevelDiff + 1));
      currentLevel = levels.get(prevLevel + 1);
    }
  }

  // draws the level and all its parts
  void renderLevel() {
    // draws the game play 
    if (!splashScreenMode && !instructionsMode) {
      fill(255);
      text(totalPoints, 22, 28);
      fill(255, 0, 0);
      text(totalPoints, 25, 25);
      currentLevel.move();
      currentLevel.render();
    }
    // draws the splashscreen when the game is in splashscreen mode
    else if (splashScreenMode) {
      splashScreen.resize(600, 0);
      image(splashScreen, 0, 0);
    }
    // draws the instructions when the game is in instructions mode
    else if (instructionsMode) {
      instructions.resize(600, 0);
      image(instructions, 0, 0);
    }
  }

  // calculates total points won by the player for all levels
  void calcPoints() {
    float levelPoints = currentLevel.points;
    pointsTilNow += levelPoints;
    totalPoints = pointsTilNow;
  }
  
  // starts the game
  void startGame() {
    splashScreenMode = false;
    instructionsMode = false;
  }
  
  // puts the game in instructions mode
  void instructionsMode() {
    splashScreenMode = false;
    instructionsMode = true;
  }
  
  // puts the game in splashscreen mode
  void splashScreenMode() {
    splashScreenMode = true;
    instructionsMode = false;
  }
}