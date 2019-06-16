/*
Final project - Intro to Creative Computing @ Sogang University 
***THE RIPARIAN STREAM*** by Sylvester Schelde Andersen
This project explores and illustrates the concept of the riparian stream, a concept coined by professor of digital humanities
David M. Berry. This concept explores the notion of rapidly moving 'streams' of data online. 
The rapidly expanding and moving 'information highway' made up of data streams, algorithms and databases, creates an 
increasingly detached publicity, who stand no chance of participating in and comprehending the vast amount and speeds of
these data streams. These have been dubbed the Riparian publicity. 
As the information exposed to us is so incomprehensible, it simultaneously makes distincting between different types of data
harder and harder, therefore trivalizing them. 

"At the outset you assume you can hold on to the rope. That you can read all the posts,
handle all the replies and use Twitter as a communications tool,
similar to IM — then at some point, as the number of people you
follow and follow you rises — your hands begin to burn. You realize
you cant hold the rope you need to just let go and observe the rope"

In this project, there are two different string of data 'flowing' through the stream at incomprehensible speeds. 
One cannot make out the content of these strings. 
The top string is taken from a database of torture reports from Amnesty International, catalouging instances of torture in 2008
in different cultures. 
The bottom string is a small part of the source code of google's front page of their search engine. It is seemingly incomprehensible 
endless code. 
These strings are of very different nature, complexity and seriousness, however, due to the speed of the Riparian Stream, they
become equally as trivalized. Users are only able to superficially observe this data. Any attempt to participate is eventually in vain. 
Likewise, if you hover the mouse over the strings, they will slow down, making them slightly more comprehensible, but
in the end not enough for own to grasp. It also becomes apparent how fractured these strings are, as they are removed from their
original context. 
There is still a small hope of understanding these strings further, as they, when clicked, open the source page for the strings
for one to study. These may, however, also not be completely comprehensible. It does instill a sense of achievement if one decides 
to actively participate in this data stream. 

In conclusion, The Riparian Stream showcases a contemporary state of affairs when navigating online, where huge amounts and speeds
of data make comprehension increasingly difficult, reducing us to superficial observers.
*/
//variables related to the wave
int xspacing = 16;   // How far apart should each horizontal location be spaced
int w;              // Width of entire wave

float theta = 0.0;  // Start angle at 0
float amplitude = 35.0;  // Height of wave
float period = 600.0;  // How many pixels before the wave repeats
float dx;  // Value for incrementing X, a function of period and xspacing
float[] yvalues;  // Using an array to store height values for the wave

//Strings and variables for creating and moving text
//string
String [] amnestywords; 
String [] googlewords;

//indexes for increasing in string arrays
int aindex;
int gindex; 

//moves the position of the strings
float gpos;
float apos;

//counts frames
int acount;
int gcount;
int acount1;
int gcount1; 

//controls the speed of the index being counted
float aspeed;
float gspeed; 

PFont font; 

float aypos = 0.0; 
float gypos = 0.0;

void setup() {
  size(1200, 800);
  w = width+16;
  dx = (TWO_PI / period) * xspacing;
  yvalues = new float[w/xspacing];
  
  font = loadFont("8-bitOperatorPlus8-Regular-48.vlw"); 
  
  //amnesty torture data loaded
  String[] amnesty = loadStrings("https://raw.githubusercontent.com/pdfliberation/amnestydata/master/parsed-data/2008%20torture%20extract.json");
  String entiretext = join(amnesty, " "); 
  amnestywords = split(entiretext, " "); 
  
  
  //google api code loaded
  String[] google = loadStrings("https://apis.google.com/_/scs/abc-static/_/js/k=gapi.gapi.en.6Hr6HfhQmkw.O/m=gapi_iframes,googleapis_client,plusone/rt=j/sv=1/d=1/ed=1/rs=AHpOoo_002wlh5Kwm-a9Vn_hwBzXlB2L_A/cb=gapi.loaded_0");
  String entiretext1 = join(google, " "); 
  googlewords = split(entiretext1, " ");
   
}

void draw() {
  background(0);
  calcWave();
  renderWave();
  
  fill(255); 
    //textSize(25);
    textAlign(CENTER);
    textFont(font, 30);
    
    //noise movement along the y-axis
    aypos = aypos + .01;
    gypos = gypos + .01;
    float n = noise(aypos) * width;
    float p = noise(gypos) * width;
    
    //maps the noise movement within desired boundaries 
     n = map(n, 0, height, height*0.4, height*0.5);
     p = map(p, 0, height, height*0.6, height*0.7);
     
    //create amnesty text 
    text(amnestywords[aindex], apos, n); 
    acount++;
    
    
    
    //create google api source text
    text(googlewords[gindex], gpos, p);
    gcount++;
    
      
     //when the texts reach the end of the sketch, restart from the beginning
    if(apos>width) {
      apos = random(-600, 100); 
    }
     if(gpos>width) {
     gpos = random(-600, 100); 
    }
 
     //this statement controls how fast the index is moved through in the amnesty string. speed indicates how many frames occur per iteration
    if(acount>aspeed) { //speed = 3 (the lower the faster)
      aindex++;
      acount = 0;
    }
    
     //this statement controls how fast the index is moved through in the google string. speed indicates how many frames occur per iteration
    if(gcount>gspeed) { //speed = 3 (the lower the faster)
      gindex++;
      gcount = 0;
    }
    
     //slow down the speed of the amnesty string when the mouse is over its path
     // text moves horizontally is slower when inside the location, and faster outside
    if(mouseX>0 && mouseX<width && mouseY>height*0.4 && mouseY<height*0.5) {
      aspeed = 12;  
      apos +=5;  
    }else{
        aspeed = 1.5; 
        apos+=10;
    }
    
    if(mouseX>0 && mouseX<width && mouseY>height*0.6 &&mouseY<height*0.7) {
      gspeed = 15; 
      gpos+=5;
    }else{
        gspeed = 2; 
        gpos+=10;
    }
    
   
    
    textFont(font, 45);
    text("The Riparian Stream", width/2, height*0.11);
    textFont(font, 28);
    text("Try to take a closer look", width/2, height*0.16);
    
 
}
//function for opening links to the source strings when clicked 
void mouseReleased() {
  if(mouseX>0 && mouseX<width && mouseY>height*0.4 && mouseY<height*0.5) {
     link("https://raw.githubusercontent.com/pdfliberation/amnestydata/master/parsed-data/2008%20torture%20extract.json");
  }
  if(mouseX>0 && mouseX<width && mouseY>height*0.6 &&mouseY<height*0.7) {
    link("https://apis.google.com/_/scs/abc-static/_/js/k=gapi.gapi.en.6Hr6HfhQmkw.O/m=gapi_iframes,googleapis_client,plusone/rt=j/sv=1/d=1/ed=1/rs=AHpOoo_002wlh5Kwm-a9Vn_hwBzXlB2L_A/cb=gapi.loaded_0");
  }
}

void calcWave() {
  // Increment theta = increase the 'speed' of the wave
  theta += 0.1;

  // For every x value, calculate a y value with sine function
  float x = theta;
  for (int i = 0; i < yvalues.length; i++) {
    yvalues[i] = sin(x)*amplitude;
    x+=dx;
  }
}

void renderWave() {
  noStroke();
  fill(255);
  // draws the wave with an ellipse at each location
  for (int x = 0; x < yvalues.length; x++) {
    ellipse(x*xspacing, height*0.25+yvalues[x], 10, 10); // top wave
    ellipse(x*xspacing, height*0.85+yvalues[x], 10, 10);// bottom wave
  }
}
