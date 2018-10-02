class Coord {
  float x;     // the x value of the coordinate
  float y;     // the y value of the coordinate
  
  // constructor to create a coordinate
  Coord(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  // set the x value to a new value
  void setX(float newX) {
    this.x = newX;
  }
  
  // set the y value to a new value
  void setY(float newY) {
    this.y = newY;
  }
  
  // render the coordinate
  // used to create the start and end portals. the image is supplied in the 
  // level class, depending on whether it's a start or end portal
  void render(PImage img) {
    imageMode(CENTER);
    img.resize(35, 0);
    image(img, x, y);
  }
}