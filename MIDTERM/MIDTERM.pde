/*MIDTERM ASSIGNMENT
QUOTE: "HOW CAN THE FINITE COMPREHEND THE INFINITE?" - H.C. Andersen (original quote in Danish) 



*/
//variables
float dg; 
float dgmin;
float sizex = 500;
float sizexspeed = 1;
float sizey = 500; 
float sizeyspeed = 1;

float x = 0.0;
float y = 0.0;
float z = 0.0;

boolean move = true;

int ballX;
float ballY;
int radius;
int ballSpeed;

PFont font; 

float textsize;
void setup() {
  size(1000, 1000, P3D);
  background(0);
  smooth(4);
 
  ballX = width/2;
  ballY = height*0.8;
  radius = 25;
  ballSpeed = 10;
  
  font = loadFont("SegoeUI-Light-48.vlw");
}
  void draw() {
    //transparent box to add fade effect
  fill(0, 0, 0, 30);
  noStroke();
  rect(0, 200, width, 800);
    
   //noise colour
  x+=.01;
  y+=.01;
  z+=.01;
  float r = noise(x)*255;
  float g = noise(x, y)*255;
  float b = noise(x, y, z)*255;
   
  //degrees of the shapes increase/decrease
  dg+=2;
  dgmin-=2;
  
  //if the boolean move is true (aka ball is not past width), execute the code
  if (move) {
  sizex = sizex + sizexspeed; //size of the shapes increase/decrease
  sizey = sizey + sizeyspeed;
  
    if (sizex > 550 || sizex <10) {
    sizexspeed = sizexspeed * -1;
    sizeyspeed = sizeyspeed * -1;
  }
  }
  
   //rotating ellipses THE INFINITE  
push();
stroke(r, g, b);
strokeWeight(3);
noFill();
translate(width*0.5, height*0.5); 
if (move) {
rotateY(radians(dg));
rotateX(radians(dg));
}
ellipse(0, 0, sizex, sizey);
if (move) {
rotateY(radians(dgmin));
rotateX(radians(dgmin));
}
ellipse(0, 0, sizex, sizey);
pop();

  //the moving ball || THE FINITE
noFill();
stroke(150);
strokeWeight(1);
ellipse(ballX, ballY, radius*2, radius*2);   

//text 
textAlign(CENTER);
if(move) {
  fill(0);
  noStroke();
  rect(300, 0, 400, 200);
  fill(255);
  for( int i = 200; i>0; i/=1.25) { //for loop for multiple text strings
  textsize = i / 5; // shrinks the size of the text according to the for loop
      textFont(font, textsize); 
text("INFINITE", width/2, i); 
  }
}else if(!move) {
  fill(0);
  noStroke();
  rect(300, 0, 4000, 200); 
  fill(255); 
  textFont(font, 42);
  text("FINITE", width/2, 200); 
}

}
 void keyPressed() {
   //moves the ball according to key presses
  if ( (keyCode == LEFT) && (ballX > radius) )
  {
    ballX = ballX - ballSpeed;
  }

  if ( (keyCode == RIGHT) && (ballX < width-radius) )
  {
    ballX = ballX + ballSpeed;
  }

  if ( (keyCode == UP) && (ballY > radius) )
  {
    ballY = ballY - ballSpeed;
  }

  if ( (keyCode == DOWN) && (ballY < height-radius) )
  {
    ballY = ballY + ballSpeed;
  }
  
  //statement that controls whether the boolean is true or false
  if (ballX>325 && ballX<675 && ballY>325 && ballY<675) {
  move = false; 
} else {
  move = true;
}
}
