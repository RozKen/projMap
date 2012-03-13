/**
 * Loop. 
 * 
 * Move the cursor across the screen to draw. 
 * Shows how to load and play a QuickTime movie file.  
 */

import processing.video.*;

Movie myMovie;
Movie myMovie2;
Image myStop;

void setup() {
  size(640, 480, P2D);
  background(0);
  // Load and play the video in a loop
  myMovie = new Movie(this, "presscube_mini.mov");
  myMovie2 = new Movie(this, "presscube_mini.mov");
	myStop = new Image(this, "presscube_mini.mov");
	myMovie.speed(0.2);
	myMovie2.speed(0.5);
  myMovie.loop();
  myMovie2.loop();	
}
void movieEvent(Movie myMovie) {
  myMovie.read();
}

void draw() {
	//unit size
	int uz = myMovie.width/1;
	
	//unit's corner where mouse on	
	int mux = mouseX-mouseX%myMovie.width;
	int muy = mouseY-mouseY%myMovie.height;
	

	if(myMovie.available()){
	image(myMovie, mux-uz, muy);
	image(myMovie, mux+uz, muy);	
	image(myMovie, mux, muy-uz);
	image(myMovie, mux, muy+uz);
	}
	if(myMovie.available()){
	image(myMovie, mux, muy);	
	}
}


void slowplay() {

}

void normalplay(){
//		myMovie.speed(1);
//		image(myMovie, mux-uz, muy);
}

/*
void mousePressed(){
  myMovie.stop();
  myMovie.play();
}
*/