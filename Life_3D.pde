import peasy.*; //<>//

int dim = 10;
int len;
int iteration = 1;

//-----------------------------------------------------//
//For visualizing neighbors
ArrayList<Box> outlined = new ArrayList<Box>();
boolean visualize = false;
int tmp_x = 0;
int tmp_y = 0;
int tmp_z = dim - 1;

int unset_x;
int unset_y;
int unset_z;
//----------------------------------------------------//

Box[][][] my_boxes = new Box[dim][dim][dim];
PeasyCam cam;

void setup() {
  size(800, 800, P3D);
  //fullScreen(P3D);
  len = (width / 2) / dim;
  cam = new PeasyCam(this, 800);
  make_squares();
  if (visualize) {
    show_neighbors();
  }
}

void draw() {
  if (visualize) {
    display_neighbors();
    
  } else {
    draw_squares(); 
    
    if (iteration % 50 == 0) {
      update_board();
    }
    
    iteration += 1;
  }
}

void update_board() {
  //Loop through the array
  for (int i = 0; i < dim; i += 1) {
    for (int j = 0; j < dim; j += 1) {
      for (int k = 0; k < dim; k += 1) {
      
        //Get neighbor count for curr square
        int neighbors = 0;
        Box curr = my_boxes[i][j][k];
        
        //Loop to check neighbors
        for (int x = -1; x < 2; x += 1) {
          for (int y = -1; y < 2; y += 1) {
            for (int z = -1; z < 2; z += 1) {
              if (x == 0 && y == 0 && z == 0) {
                continue;
              }
              
              //Code to get index with wrap around effect
              int check_x = (i + x + dim) % dim;
              int check_y = (j + y + dim) % dim;
              int check_z = (k + z + dim) % dim;
              
              if (my_boxes[check_x][check_y][check_z].get_status() == 1) {
                neighbors += 1;
              }
            }
          }
        }
        
        //Set status based on neighbor count
        if (curr.get_status() == 0 && neighbors == 3) {
          curr.set_next(1);
        } else if (curr.get_status() == 1 && (neighbors == 2 || neighbors == 3)) {
          curr.set_next(1);
        } else {
          curr.set_next(0);
        }
      }
    }
  }
}

void draw_squares() {
  background(200);
  //Draw the new squares
  for (int x = 0; x < dim; x += 1) {
    for (int y = 0; y < dim; y += 1) {
       for (int z = 0; z < dim; z += 1) {
          my_boxes[x][y][z].draw_me();
       }      
    }
  }
}

void make_squares() {
  int offset = (dim - 1) * len / 2;
  
  for (int x = 0; x < dim; x += 1) {
    for (int y = 0; y < dim; y += 1) {
       for (int z = 0; z < dim; z += 1) {
          Box new_square = new Box(x * len - offset, y * len - offset, z * len - offset, len);
          my_boxes[x][y][z] = new_square;
       }      
    }
  }
}

//-----------------------------------------------------------------------//
//For visualizing finding neighbors

void keyTyped() {
  if (key == 32) {
    visualize = !visualize;
  }
  
  if (visualize && key == 32) {
    show_neighbors();
  }
  
  if (visualize) {
    //Key controls for moving the current square
    if (key == 'a') {
      //Left
      tmp_x -= 1;
    } else if (key == 'd') {
      //Right
      tmp_x += 1;
    } else if (key == 'w') {
      //Up
      tmp_y -= 1;
    } else if (key == 's') {
      //Down
      tmp_y += 1;
    } else if (key =='q') {
      //In
      tmp_z -= 1;
    } else if (key == 'e') {
      //Out
      tmp_z += 1;
    }
    
    //Check indexes
    if (tmp_x == dim) {
      tmp_x = 0;
    } else if (tmp_x < 0) {
      tmp_x = dim - 1;
    }
    
    if (tmp_y == dim) {
      tmp_y = 0;
    } else if (tmp_y < 0) {
      tmp_y = dim - 1;
    }
    
    if (tmp_z == dim) {
      tmp_z = 0;
    } else if (tmp_z < 0) {
      tmp_z = dim - 1;
    }
    
    show_neighbors();
    
  }
  
}

void display_neighbors() {
  background(200);
  for(int x = 0; x < dim; x += 1) {
    for (int y = 0; y < dim; y += 1) {
      for (int z = 0; z < dim; z += 1) {
        my_boxes[x][y][z].display_neighbors();
      }
    }
  }
}

void show_neighbors() {
  //Unset any boxes with special outlines
  for (int i = 0; i < outlined.size(); i += 1) {
    outlined.get(i).unset_outline();
  }
  
  //Set current square and try to unset previous square
  try {
    my_boxes[unset_x][unset_y][unset_z].unset_current();
  } catch (Exception e) {}
  
  my_boxes[tmp_x][tmp_y][tmp_z].set_current();
  
  outlined = new ArrayList<Box>();
  
  //Loop to check neighbors
  for (int x = -1; x < 2; x += 1) {
    for (int y = -1; y < 2; y += 1) {
      for (int z = -1; z < 2; z += 1) {
        if (x == 0 && y == 0 && z == 0) {
          continue;
        }
        
        //Code to get index with wrap around effect
        int X = (tmp_x + x + dim) % dim;
        int Y = (tmp_y + y + dim) % dim;
        int Z = (tmp_z + z + dim) % dim;
        
        my_boxes[X][Y][Z].set_outline();
        outlined.add(my_boxes[X][Y][Z]);
        
      }
    }
  }
  
  //Set variables for unsetting the current box next iteration
  unset_x = tmp_x;
  unset_y = tmp_y;
  unset_z = tmp_z;
}
