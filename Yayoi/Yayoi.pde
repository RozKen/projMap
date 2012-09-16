import toxi.geom.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;

import processing.video.*;

MovieMaker mm;

int NUM_PARTICLES = 750;
int minr = 15;
int maxr = 30;
int offset = 5;
float jitter = 0.1f;

VerletPhysics2D physics;
AttractionBehavior mouseAttractor;

Vec2D mousePos;

void setup() {
  size(1280, 960);  //P2Dがない方が早く動く…!?!?
  mm = new MovieMaker(this, width, height, "drawing.mov");
  smooth();
  // setup physics with 10% drag
  physics = new VerletPhysics2D();
  physics.setDrag(0.05f);
  physics.setWorldBounds(new Rect(maxr/2, maxr/2, width-maxr, height-maxr));
  // the NEW way to add gravity to the simulation, using behaviors
//  physics.addBehavior(new GravityBehavior(new Vec2D(0, 0.15f)));
}

void addParticle(float radius) {
  Particle p = new Particle(random(width), random(height), radius);
  physics.addParticle(p);
  // add a negative attraction force field around the new particle
  physics.addBehavior(new AttractionBehavior(p, p.radius+offset, -1.2f, jitter));
}

void addParticle(float radius, int x, int y) {
  Particle p = new Particle(x, y, radius);
  physics.addParticle(p);
  // add a negative attraction force field around the new particle
  physics.addBehavior(new AttractionBehavior(p, p.radius+offset, -1.2f, jitter));
}

void draw() {
  background(0);
  noStroke();
  //fill(random(255), random(255), random(255));
  fill(0,255,255);

  if (physics.particles.size() < NUM_PARTICLES) {
    for (int i = 0; i<NUM_PARTICLES; i++){
      addParticle(random(minr,maxr));
    }
  }
  
  if (keyPressed){
    addParticle(random(minr,maxr),mouseX,mouseY);
  }
  
  physics.update();
  
  for (int i = 0; i<physics.particles.size(); i++){
    Particle p = (Particle) physics.particles.get(i);
    //fill(random(200), random(200), random(200));
    ellipse(p.x, p.y, p.radius, p.radius);
  }
//  mm.addFrame();
}

class Particle extends VerletParticle2D{
  float radius;
  Particle(float x, float y, float radius) {
    super(x,y);
    this.radius = radius;
  }
}



void mousePressed() {
  mousePos = new Vec2D(mouseX, mouseY);
  // create a new positive attraction force field around the mouse position (radius=250px)
  mouseAttractor = new AttractionBehavior(mousePos, 250, -0.5f);
  physics.addBehavior(mouseAttractor);
}

void mouseDragged() {
  // update mouse attraction focal point
  mousePos.set(mouseX, mouseY);
}

void mouseReleased() {
  // remove the mouse attraction when button has been released
  physics.removeBehavior(mouseAttractor);
}

void keyPressed() {
  if (key == 'e') {
    // Finish the movie if space bar is pressed
//    mm.finish();
    // Quit running the sketch once the file is written
    exit();
  }
}


