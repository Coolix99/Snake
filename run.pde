void make1move() {
  AI.compute();                          //decide a move
  h.move();                              //move
  h.collide();                           //check for collision
  if (h.eat()) spreadFood();             //eat food?
  maxFit();                              //calculate the max fitness´
  time++;                                //add to the death timer
  if (time>maxtime) h.alive = false;     //check deathtimer
}


void run1snake() {
  while (h.alive == true) {
    make1move();
  }
}
