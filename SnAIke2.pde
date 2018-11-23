// NOTE:    when it comes to directions 1 = north/up, 2 = east/right, 3 = south/down, 4 = west/left

int size = 10;         //size of the grid                                                       Settings
int fps = 25;          //fps
int pop = 100;          //size of the population
int mutechance = 1;    //chance of mutations
int maxtime = 200;     //how long before timeout                                                  ---


int timer = 0;         //time keeping
float speed = 0.2;     //how long it takes to traverse 1 grid in seconds
int foodX;             //x and y of the food
int foodY;
int time;              //deathtimer
int count = 0;         //snake number
int gen = 0;           //gereration count
int maxfit=0;          //highest fitnes
int genMaxfit=0;       //highest fitnes of the generation
int oldGenMaxfit=0;    //highest fitnes of the last generation
float avg;             //last generations avarage
PrintWriter printer;   //readouts printer
int sidebar = 200;     //sidebar width
int mode = 0;          //what happens
boolean animation=true;     //whether or not to animate


head h = new head(0, 0);        //snake
AI AI = new AI();               //AI


void setup() {
  printer = createWriter("fitness.txt");    //readouts printer
  size(600, 400);                           //size of the screen    (+200 for sidebar)                                    <----------------------------[size]---
  frameRate(fps);                           //framerate
  spreadFood();                             //put the food in a random place
  printer.println("START:  " + day() + "/" + month() + "/" + year() + "    --    " + hour() + ":" + minute() + ":" + second());  //print the header for the output
  printer.println();
  printer.println("size: " + (width-sidebar) + "*" + height + " - " + size + "  |  target fps: " + fps);
  printer.println("population size: " + pop + "  |  mutation chance: " + mutechance + "%" + "  |  max time between apples: " + maxtime);
  printer.println();
  printer.println();
  printer.println();
  printer.flush();
}


void draw() {                                        //mode 0==freeze, 1==slomo, 2==normal, 3==onegen, 4==gens, 5==superspeed
  if (mode == 0) {
    animation=true;
    h.align();
    //
    //
  } else if (mode == 1) {    //slomo
    speed=0.5;
    animation=true;
    frameRate(fps);  
    if (millis() >= timer + speed * 1000) {  //do all this at regular intervals (set with speed)
      timer = millis();
      h.align();                           //make shure animation is in correct spot
      make1move();                         //make one move
    }
    //
    //
  } else if (mode == 2) {    //normal
    speed=0.2;
    animation=true;
    frameRate(fps);  
    if (millis() >= timer + speed * 1000) {  //do all this at regular intervals (set with speed)
      timer = millis();
      h.align();                           //make shure animation is in correct spot
      make1move();                         //make one move
    }
    //
    //
  } else if (mode == 3) {    //onegen
    animation=false;
    Boolean x = true;
    while (x) {
      run1snake();
      reset();
      if (count >= pop) {                    //if the generation is done: reset
        nextGen();
        x=false;
        mode = 0;
      }
    }
    //
    //
  } else if (mode == 4) {     //fast
    speed=0.01;
    animation=false;
    frameRate(fps);  
    if (millis() >= timer + speed * 1000) {  //do all this at regular intervals (set with speed)
      timer = millis();
      h.align();                           //make shure animation is in correct spot
      make1move();                         //make one move
    }
    //
    //
  } else if (mode == 5) {    //super speed
    animation=false;
    frameRate(1000000000);
    Boolean x = true;
    for (int i=0; i<100; i++) { 
      while (x) {
        run1snake();
        reset();
        if (count >= pop) {                    //if the generation is done: reset
          nextGen();
          x=false;
        }
      }
    }
  }

  if (!h.alive) {                          //whan the snake dies: reset
    reset();
    if (count >= pop) {                    //if the generation is done: reset
      nextGen();
    }
  }
  render();                                //display it all
}


void mousePressed() {
  if (mouseX>width-160 && mouseY>height-50 && mouseY<height-10) mode = 5; 
  if (mouseX>width-160 && mouseY>height-100 && mouseY<height-60) mode = 4; 
  if (mouseX>width-160 && mouseY>height-150 && mouseY<height-110) mode = 3; 
  if (mouseX>width-160 && mouseY>height-200 && mouseY<height-160) mode = 2; 
  if (mouseX>width-160 && mouseY>height-250 && mouseY<height-210) mode = 1; 
  if (mouseX>width-160 && mouseY>height-300 && mouseY<height-260) mode = 0;
}
