class Box {
  
  int len;
  PVector pos;
  
  int curr_state = 0;
  int next_state = 0;
  int outline = 0;
  int current = 0;
  
  color pink = color(255, 166, 201);
  
  Box(int x, int y, int z, int len) {
    pos = new PVector(x, y, z);
    this.len = len;
    next_state = (int)random(4);
    curr_state = next_state;
  }
  
  void draw_me() {
    curr_state = next_state;
    
    
    //Draw the square
    if (curr_state == 1) {
      stroke(150);
      fill(pink);
      
    } else {
      noStroke();
      noFill();
    }
    
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    box(len);
    popMatrix();
    
  }
  
  int get_status() {
    return curr_state;
  }
  
  void set_next(int next) {
    next_state = next;
  }
  
  //----------------------------------------//
  
  //For visualizing finding neighbors
  void set_outline() {
    outline = 1; 
  }
  
  void unset_outline() {
    outline = 0;
  }
  
  void set_current() {
    current = 1;
  }
  
  void unset_current() {
    current = 0;
  }
  
  void display_neighbors() {
    //println("Curr state: " + curr_state + "  Next state: " + next_state);
    curr_state = next_state;
    color col = color(8, 232, 222);
    
    //Draw pink if alive
    if (curr_state == 1) {
      //Draw outline if possible neighbor
      if (outline == 1) {
        stroke(col);
        if (curr_state == 1) {
          fill(col);
        }
      } else {
        fill(pink);
        stroke(150);
      }
      
      //Figure out if outline for neighbor or no drawing
    } else {
      if (outline == 1) {
        stroke(col);
        noFill();
      }
    }
    
    //If current set black/white
    if (current == 1) {
      if (curr_state == 1) {
        fill(255);
      } else {
        noFill();
      }
      stroke(0);
    }
    
    //Only draw if alive or neighbor
    if (curr_state == 1 || outline == 1 || current == 1) {
      pushMatrix();
      translate(pos.x, pos.y, pos.z);
      box(len);
      popMatrix();
    }
  }
  
}
