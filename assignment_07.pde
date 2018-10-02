/** 
Yuliya Smilyanski
 y.smilyanski@gmail.com
 ARTG 2260
 Section 1
 Assignment 7
 GAME NAME: "Drone Dash"
 **/

import processing.pdf.*;

// the game object implementation
Game g;

void setup() {
  size(600, 600);
  g = new Game();
}

void draw() {
  background(127);
  g.renderLevel();
  g.addLevel();
}

void keyPressed() {
  if (key == 's') {
    saveFrame("sketch-####.png");
  }
}

void mousePressed() {
  // splash screen mode
  // allows clicking of buttons on the splash screen
  if (g.splashScreenMode) {
    if (mouseX >= 343.0 && mouseX <= 507.0 && mouseY >= 406.0 && mouseY <= 490.0) {
      g.startGame();
    }
    if (mouseX >= 91 && mouseX <= 292 && mouseY >= 445 && mouseY <= 488) {
      g.instructionsMode();
    }
    
  // instructions mode
  // allows clicking of buttons on the instructions screen
  } else if (g.instructionsMode) {
    if (mouseX >= 66 && mouseX <= 156 && mouseY >= 34 && mouseY <= 79) {
      g.splashScreenMode();
    }
    
  // game mode!
  // allows the user to play the game
  } else if (!g.splashScreenMode && !g.instructionsMode) {
    g.currentLevel.player.setTarget(mouseX, mouseY);
  }
}
