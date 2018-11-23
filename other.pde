void spreadFood () {                                                //randomize the food
  boolean exit = false;
  while (exit == false) {                                           //make shure food isn't under snake
    exit = true;
    foodX = size*int(random(floor((width-sidebar)/size)));
    foodY = size*int(random(floor((width-sidebar)/size)));
    for (int i=0; i<h.tailX.size(); i++) {                          
      if (foodX == h.tailX.get(i) && foodY == h.tailY.get(i) ) {
        exit = false;
      }
    }
  }
}



void maxFit() {                                                     //calculate the max fitness of the snake
  if (h.tailX.size()>maxfit) {
    maxfit = h.tailX.size();
  }
  if (h.tailX.size()>genMaxfit) {
    genMaxfit = h.tailX.size();
  }
}



void render() {
  background(0);
  noStroke();
  fill(0, 200, 0);
  rect(1, 1, size*(floor((width-sidebar)/size))-2, size*(floor(height/size))-2);    //draw playing field
  fill(200, 0, 0);
  rect(foodX+size*0.1, foodY+size*0.1, size*0.8, size*0.8);               //draw food
  h.render();                                                             //draw snake
  fill(255);
  textAlign(RIGHT, BOTTOM);                                               //score
  text("gen:"+gen + "   #:" + count + "   score:" + (h.tailX.size()-1), width-5, 20);
  text("max:" + (maxfit-1) + "   genMax:" + (genMaxfit-1), width-5, 35);
  text("lastGenMax:" + (oldGenMaxfit-1), width-5, 50);
  text("lastGenAvg:" + (avg-1), width-5, 65);
  text("time: " + floor(millis()/3600000) + " h. " + (floor(millis()/60000) % 60) + " min. " + (floor(millis()/1000) % 60) + " sec.", width-5, 80);
 
 
  text("max speed gens", width-10, height-10);              //buttons
  text("fast", width-10, height-60);
  text("one gen", width-10, height-110);
  text("normal", width-10, height-160);
  text("slow", width-10, height-210);
  text("stop", width-10, height-260);

  noFill();
  stroke(255);                                          //button boxes
  rect(width-10, height-10, -150, -40);
  rect(width-10, height-60, -150, -40);
  rect(width-10, height-110, -150, -40);
  rect(width-10, height-160, -150, -40);
  rect(width-10, height-210, -150, -40);
  rect(width-10, height-260, -150, -40);
}
