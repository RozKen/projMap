ArrayList balls;
ArrayList vels;
ArrayList colors;

void setup() {
  size(640, 360);
  smooth();
  noStroke();
  balls = new ArrayList();
  balls.add(new Ball(100, 400, 20));
  balls.add(new Ball(700, 400, 80));
  balls.add(new Ball(500, 200, 15));
  
  vels = new ArrayList();
  vels.add(new PVector(2.15, -1.35));
  vels.add(new PVector(-1.65, .42));
  vels.add(new PVector(0, -9.8));
  
  colors = new ArrayList();
  colors.add(new Color(100, 100, 100));
  colors.add(new Color(200, 0, 0));
  colors.add(new Color(0, 200, 0));
}

void draw() {
  background(51);
  for (int i=0; i< balls.size(); i++){
    Ball ball = (Ball)balls.get(i);
    PVector vel = (PVector) vels.get(i);
    Color col = (Color) colors.get(i);
    fill(col.r, col.g, col.b);
    ball.x += vel.x;
    ball.y += vel.y;
    ellipse(ball.x, ball.y, ball.r*2, ball.r*2);
    checkBoundaryCollision(ball, vel);
  }
  checkObjectCollision(balls, vels);
}
float ballWidth = 5.0f;
void mousePressed() {
  // A new ball object is added to the ArrayList, by default to the end
  balls.add(new Ball(mouseX, mouseY, ballWidth));
  vels.add(new PVector(0, 9.8));
  colors.add(new Color(0, 200, 200));
}

void checkObjectCollision(ArrayList b, ArrayList v){
  for(int i = 0; i < b.size() - 1; i++){
    for(int j = i + 1; j < b.size(); j++){
      // get distances between the balls components
      PVector bVect = new PVector();
      Ball[] balls = { (Ball) b.get(i), (Ball) b.get(j) };
      PVector[] vels = { (PVector) v.get(i), (PVector) v.get(j) };
      bVect.x = balls[1].x - balls[0].x;
      bVect.y = balls[1].y - balls[0].y;
    
      // calculate magnitude of the vector separating the balls
      float bVectMag = sqrt(bVect.x * bVect.x + bVect.y * bVect.y);
      if (bVectMag < balls[0].r + balls[1].r){
        // get angle of bVect
        float theta  = atan2(bVect.y, bVect.x);
        // precalculate trig values
        float sine = sin(theta);
        float cosine = cos(theta);
    
        /* bTemp will hold rotated ball positions. You 
         just need to worry about bTemp[1] position*/
        Ball[] bTemp = {  
          new Ball(), new Ball()          };
          
        /* balls[1]'s position is relative to balls[0]'s
         so you can use the vector between them (bVect) as the 
         reference point in the rotation expressions.
         bTemp[0].x and bTemp[0].y will initialize
         automatically to 0.0, which is what you want
         since balls[1] will rotate around balls[0] */
        bTemp[1].x  = cosine * bVect.x + sine * bVect.y;
        bTemp[1].y  = cosine * bVect.y - sine * bVect.x;
    
        // rotate Temporary velocities
        PVector[] vTemp = { 
          new PVector(), new PVector()         };
        vTemp[0].x  = cosine * vels[0].x + sine * vels[0].y;
        vTemp[0].y  = cosine * vels[0].y - sine * vels[0].x;
        vTemp[1].x  = cosine * vels[1].x + sine * vels[1].y;
        vTemp[1].y  = cosine * vels[1].y - sine * vels[1].x;
    
        /* Now that velocities are rotated, you can use 1D
         conservation of momentum equations to calculate 
         the final velocity along the x-axis. */
        PVector[] vFinal = {  
          new PVector(), new PVector()          };
        // final rotated velocity for balls[0]
        vFinal[0].x = ((balls[0].m - balls[1].m) * vTemp[0].x + 2 * balls[1].m * 
          vTemp[1].x) / (balls[0].m + balls[1].m);
        vFinal[0].y = vTemp[0].y;
        // final rotated velocity for balls[0]
        vFinal[1].x = ((balls[1].m - balls[0].m) * vTemp[1].x + 2 * balls[0].m * 
          vTemp[0].x) / (balls[0].m + balls[1].m);
        vFinal[1].y = vTemp[1].y;
    
        // hack to avoid clumping
        bTemp[0].x += vFinal[0].x;
        bTemp[1].x += vFinal[1].x;
    
        /* Rotate ball positions and velocities back
         Reverse signs in trig expressions to rotate 
         in the opposite direction */
        // rotate balls
        Ball[] bFinal = { 
          new Ball(), new Ball()         };
        bFinal[0].x = cosine * bTemp[0].x - sine * bTemp[0].y;
        bFinal[0].y = cosine * bTemp[0].y + sine * bTemp[0].x;
        bFinal[1].x = cosine * bTemp[1].x - sine * bTemp[1].y;
        bFinal[1].y = cosine * bTemp[1].y + sine * bTemp[1].x;
    
        // update balls to screen position
        balls[1].x = balls[0].x + bFinal[1].x;
        balls[1].y = balls[0].y + bFinal[1].y;
        balls[0].x = balls[0].x + bFinal[0].x;
        balls[0].y = balls[0].y + bFinal[0].y;
    
        // update velocities
        vels[0].x = cosine * vFinal[0].x - sine * vFinal[0].y;
        vels[0].y = cosine * vFinal[0].y + sine * vFinal[0].x;
        vels[1].x = cosine * vFinal[1].x - sine * vFinal[1].y;
        vels[1].y = cosine * vFinal[1].y + sine * vFinal[1].x;
      }
    }
  }
}

void checkBoundaryCollision(Ball ball, PVector vel) {
  if (ball.x > width-ball.r) {
    ball.x = width-ball.r;
    vel.x *= -1;
  } 
  else if (ball.x < ball.r) {
    ball.x = ball.r;
    vel.x *= -1;
  } 
  else if (ball.y > height-ball.r) {
    ball.y = height-ball.r;
    vel.y *= -1;
  } 
  else if (ball.y < ball.r) {
    ball.y = ball.r;
    vel.y *= -1;
  }
}

class Ball{
  float x, y, r, m;

  // default constructor
  Ball() {
  }

  Ball(float x, float y, float r) {
    this.x = x;
    this.y = y;
    this.r = r;
    m = r*.1;
  }
};

class Color{
  int r, g, b;
  // default constructor
  Color(){
  }
  
  Color(int r, int g, int b){
    this.r = r;
    this.g = g;
    this.b = b;
  }
};
