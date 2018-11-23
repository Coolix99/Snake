void reset() {
  time = 0;                            //reset deathtimer
  spreadFood();                        //randomize the food
  h.alive = true;                      //revive the snake
  AI.score[count] = h.tailX.size();    //save the score
  h.tailX.clear();                     //reset score
  h.tailY.clear();
  h.moving = -10;                      //reset the movement & position
  h.x = 0;
  h.y = 0;
  h.grow();
  count++;                             //go to the next snake
}


void nextGen() {
  oldGenMaxfit = genMaxfit;                    //save old maxfitness
  avg=0;                                       //calculate avarage
  for (int i=0; i<AI.score.length; i++) {
    avg += AI.score[i];
  }
  avg /= AI.score.length;
  AI.weights = AI.newW();                      //repreduce
  printer.println("-------" + gen + "-------");                                                                                        //save data
  printer.println("time: " + floor(millis()/3600000) + " h. " + (floor(millis()/60000) % 60) + " min. " + (floor(millis()/1000) % 60) + " sec.");
  printer.println();
  printer.println("max:" + maxfit + "  genMax:" + oldGenMaxfit + "  genAvg:" + avg);
  printer.println();
  printer.println();
  printer.flush();
  count = 0;                                //reset snake counter
  gen++;                                    //update generation counter
  genMaxfit = 0;                            //reset generations maxfit;
}
