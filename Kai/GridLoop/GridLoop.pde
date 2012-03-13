/**
 * Loop. 
 * 
 * Move the cursor across the screen to draw. 
 * Shows how to load and play a QuickTime movie file.  
 */

import processing.video.*;

Movie myMovie;

void setup() {
  size(640, 480, P2D);
  background(0);
  // Load and play the video in a loop
  myMovie = new Movie(this, "presscube_mini.mov");
  myMovie.play();
}

void movieEvent(Movie myMovie) {
  myMovie.read();
}

void draw() {
  background(0);
  // tint(255, 20);  //Color Overlay
  image(myMovie, mouseX-mouseX%myMovie.width, mouseY-mouseY%myMovie.height);
  //image(myMovie, mouseX, mouseY);
}
