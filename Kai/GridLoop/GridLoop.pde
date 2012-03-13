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
	// define unit size
	int uz = 20;
	int[][] unitcenterx = new int[width/uz][height/uz];
	int[][] unitcentery = new int[width/uz][height/uz];
	for (int i = 0; i < width/20 ; ++i){
		for (int j = 0; j < height/20 ; ++j){
			unitcenterx[i][j]=uz*i+uz/2;
			unitcentery[i][j]=uz*i+uz/2;
		}
	}
  // Load and play the video in a loop
  myMovie = new Movie(this, "presscube_mini.mov");
//  myMovie.loop();

	print(unitarray[1][1]);
}
void movieEvent(Movie myMovie) {
  myMovie.read();
}

void draw() {
	int uz = myMovie.width;
	int mux = mouseX-mouseX%myMovie.width;
	int muy = mouseY-mouseY%myMovie.height;

  background(0);
  // tint(255, 20);  //Color Overlay
  myMovie.loop();
  image(myMovie, mux, muy);
  image(myMovie, mux+uz, muy+uz);
  //image(myMovie, mouseX, mouseY);
	print(unitcenterx[1][1]);
}

/*
void mousePressed(){
  myMovie.stop();
  myMovie.play();
}
*/