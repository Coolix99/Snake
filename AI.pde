class AI {

  int eye1;
  int eye2;
  int eye3;
  int eye4;
  int f1;
  int f2;
  int f3;
  int f4;
  int ins = 8;
  float nodes[] = new float[8];
  float outs[] = new float[4];
  int score[] = new int[pop];
  int weightCount = 96;
  float weights[][] = new float[pop][weightCount];


  AI () {
    for (int i=0; i<pop; i++) {
      for (int j=0; j<weightCount; j++) {
        weights[i][j] = random(-1, 1);          //random starting waits
      }
    }
  }



  void compute () {
    see();                                  //take input readings
    for (int i=0; i<nodes.length; i++) {                              //calculate the nodes (inputs -> nodes)
      nodes[i] = 0;

      nodes[i] += eye1 * weights[count][i*nodes.length + 0];
      nodes[i] += eye2 * weights[count][i*nodes.length + 1];
      nodes[i] += eye3 * weights[count][i*nodes.length + 2];
      nodes[i] += eye4 * weights[count][i*nodes.length + 3];
      nodes[i] += f1 * weights[count][i*nodes.length + 4];
      nodes[i] += f2 * weights[count][i*nodes.length + 5];
      nodes[i] += f3 * weights[count][i*nodes.length + 6];
      nodes[i] += f4 * weights[count][i*nodes.length + 7];

      nodes[i] = (1/1+exp(nodes[i]))*-2 + 1;                       //sigmoid function
    }

    for (int i=0; i<outs.length; i++) {       //calculate the outputs (nodes -> outs)
      outs[i] = 0;
      for (int j=0; j<nodes.length; j++) {
        outs[i] += nodes[j] * weights[count][i*nodes.length + j + 37];
      }
      outs[i] = ((1/(1+exp(outs[i])))*-2) + 1;                        //sigmoid function
    }

    float highestOutput = -2;                         //find index of larges out                               
    int out = 0;  
    for (int i=0; i<outs.length; i++) {
      if (outs[i] > highestOutput) {
        highestOutput = outs[i];
        out = i+1;                                   //new highes Index (+1 because snake input is 1-4 not 0-3)
      }
    }
    //if (h.moving != out + 2 && h.moving != out - 2) {      //check for illegal moves and send move
      h.moving = out;
    //}
  }



  float[][] newW () {                                  //reproduction
    float newW[][] = new float[pop][weightCount];
    float n[] = new float[pop];
    for (int i=0; i<pop; i++) {
      n[i] = (pow((score[i]/(genMaxfit+0.001))*10, 4))+0.001;
    }
    for (int i=0;  i<pop; i++) {                //for every population member:     
      boolean check=false;                     //choose two parants indexes a and b using accept/reject randomness
      int a = 0;
      int b = 0;
      while (!check) {             
        a = floor(random(pop));
        if (random(n[a])>random(10000)) {
          check = true;
        }
      }
      check=false;
      while (!check) {
        b = floor(random(pop));
        if (random(n[b])>random(10000)) {
          check = true;
        }
      }
      int midpoint = floor(random(weightCount));     //choose a random midpoint in the DNA
      for (int j=0; j<weightCount; j++) {            //take half of parant a and half from parant b 
        if (random(100)<mutechance) {
          newW[i][j] = random(-1, 1);                //mutations?
        } else {
          if (j<midpoint) {
            newW[i][j] = weights[a][j];
          } else {
            newW[i][j] = weights[b][j];
          }
        }
      }
    }
    return newW;                                  //return offspring
  }

  void see () {                                    //read input
    eye1 = -1;
    eye2 = -1;
    eye3 = -1;
    eye4 = -1;
    for (int i=1; i<h.tailX.size(); i++) {
      if (h.x == h.tailX.get(i) && h.y-size == h.tailY.get(i)) {    //eye1
        eye1 = 1;
      }
    }
    if (h.x > size*(floor((width-sidebar)/size))-2 || h.y-size > size*(floor(height/size))-2 || h.x < 0 || h.y-size < 0) {
      eye1 = 1;
    }

    for (int i=1; i<h.tailX.size(); i++) {
      if (h.x+size == h.tailX.get(i) && h.y == h.tailY.get(i)) {    //eye2
        eye2 = 1;
      }
    }
    if (h.x+size > size*(floor((width-sidebar)/size))-2 || h.y > size*(floor(height/size))-2 || h.x+size < 0 || h.y < 0) {
      eye2 = 1;
    }

    for (int i=1; i<h.tailX.size(); i++) {
      if (h.x == h.tailX.get(i) && h.y+size == h.tailY.get(i)) {    //eye3
        eye3 = 1;
      }
    }
    if (h.x > size*(floor((width-sidebar)/size))-2 || h.y+size > size*(floor(height/size))-2 || h.x < 0 || h.y+size < 0) {
      eye3 = 1;
    }

    for (int i=1; i<h.tailX.size(); i++) {
      if (h.x-size == h.tailX.get(i) && h.y == h.tailY.get(i)) {    //eye4
        eye4 = 1;
      }
    }
    if (h.x-size > size*(floor((width-sidebar)/size))-2 || h.y > size*(floor(height/size))-2 || h.x-size < 0 || h.y < 0) {
      eye4 = 1;
    }

    f1=-1;
    f2=-1;
    f3=-1;
    f4=-1;
    if (h.y>foodY) f1 = 1;
    if (h.x<foodX) f2 = 1;
    if (h.y<foodY) f3 = 1;
    if (h.x>foodX) f4 = 1;
  }
}
