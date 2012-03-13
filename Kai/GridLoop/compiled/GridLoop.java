import processing.core.*; 
import processing.xml.*; 

import processing.video.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class GridLoop extends PApplet {

/**
 * Loop. 
 * 
 * Move the cursor across the screen to draw. 
 * Shows how to load and play a QuickTime movie file.  
 */



Movie myMovie;

public void setup() {
  size(640, 480, P2D);
  background(0);
  // Load and play the video in a loop
  myMovie = new Movie(this, "presscube.mov");
  myMovie.loop();
}

public void movieEvent(Movie myMovie) {
  myMovie.read();
}

public void draw() {
  tint(255, 20);
  image(myMovie, mouseX-mouseX%myMovie.width, mouseY-mouseY%myMovie.height);
}
  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "GridLoop" });
  }
}
