/**
 * Loop. 
 * 
 * Move the cursor across the screen to draw. 
 * Shows how to load and play a QuickTime movie file.  
 */

import processing.video.*;

Movie myMovie;
Movie myMovie2;
Movie[][] myMovies;

void setup() {
  size(640, 480, P2D);
  background(0);
  // Load and play the video in a loop
	
	for (int i = 0; i<20; i++){
		for (int j = 0; j<20; j++){
		 myMovies[i][j] = new Movie(this, "station.mov");
		}
	}
	

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
	
		for (int i = 0; i<20; i++){
			for (int j = 0; j<20; j++){
				if(myMovies[i][j].available()){
					myMovies[i][j].loop();
					if (i == mux-1 || i == mux+1){				//for cubes next to on-cube
						myMovies[i][j].speed(0.2);
						image(myMovies[i][j], i*uz, j*muy);
						}else if (i == mux) {									//for on-cube
						myMovies[i][j].speed(0.5);
						image(myMovies[i][j], i*uz, j*muy);
					}
				}
			}
		}
	

	println(myMovies[3][3]);
//	myMovie[3][3].loop();
//	image(myMovie[3][3], 3*uz, 3*muy);
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