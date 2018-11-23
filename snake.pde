class head {

  int x;
  int y;
  int dx;      //used for animation
  int dy;  
  int moving = -10;                     //direction
  IntList tailY = new IntList();
  IntList tailX = new IntList();
  boolean alive = true;

  head (int x_, int y_) {
    x = x_;
    y = y_;
    dx = x_;
    dy = y_;
  }



  void move () {
    for (int i=tailX.size()-1; i>0; i--) {    //update tail
      tailX.set(i, tailX.get(i-1));
      tailY.set(i, tailY.get(i-1));
    }
    tailX.set(0, x);
    tailY.set(0, y);

    switch (moving) {
    case 1:  
      y -= size;
      return;
    case 2:  
      x += size;
      return;
    case 3:  
      y += size;
      return;
    case 4:  
      x -= size;
      return;
    }
  }



  void align () {
    dx = x;
    dy = y;
  }



  void grow () {
    tailX.append(x);
    tailY.append(y);
  }

  Boolean eat () {
    if (x == foodX && y == foodY) {
      grow();
      time = 0;
      return true;
    } else return false;
  }



  void collide () {
    for (int i=1; i<tailX.size(); i++) {
      if (x == tailX.get(i) && y == tailY.get(i)) {    //self colision
        alive = false;
      }
    }
    if (x > size*(floor((width-sidebar)/size))-2 || y > size*(floor(height/size))-2 || x < 0 || y < 0) {
      alive = false;
    }
  }



  void render () {
    fill(0, 100, 100);
    stroke(0, 50, 50);
    if (animation) {
      if (dx<x) dx += size/(speed*fps);        //animation
      if (dy<y) dy += size/(speed*fps);
      if (dx>x) dx -= size/(speed*fps);
      if (dy>y) dy -= size/(speed*fps);
      rect(dx, dy, size, size);
    }
    for (int i=0; i<tailX.size(); i++) {    //tail
      rect(tailX.get(i), tailY.get(i), size, size);
    }
  }
}
