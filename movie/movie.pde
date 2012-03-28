/**
 * Loop. 
 * 
 * Move the cursor across the screen to draw. 
 * Shows how to load and play a QuickTime movie file.  
 */

import processing.video.*;

Movie myMovie;

//henyohenyo

void setup() {
  size(640, 480, P2D);
  background(0);
  // Load and play the video in a loop
  myMovie = new Movie(this, "gate.mov");
  myMovie.loop();
}

void movieEvent(Movie myMovie) {
  myMovie.read();
}

void draw() {
  tint(255, 20);
  image(myMovie, mouseX-myMovie.width/2, mouseY-myMovie.height/2,width,height);
}
