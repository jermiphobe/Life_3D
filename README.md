# Life_3D

[Conway's Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life)

After watching more Processing tutorials and examples to pass the time in quarantine, I learned that it was pretty easy to do 3D graphics.  So I had to give it a shot!   And since I'm somewhat obsessed with the Game of Life, what better way to try 3D graphics than with a three-dimensional Game of Life simulation.  

I didn't do anything super fancy for this one.  I used a three dimensional array to hold all of the town cube objects.  I also used the same neighboring rules as the 2D version, there's just more neighbors to check.  To check those two extra layers of neighbors I just needed an extra nested for loop to check the third dimension of the array.  I also imported a library that allows you to click and drag to rotate the image.  You can zoom in and out with the scroll wheel too.

One extra thing I did in this program is a way to visualize how it counts the neighbors for a given town.  I had a hard time at first seeing if the neighbor count was working correctly and if the board was getting updated properly.  I decided the only proper way to check this was to create a way to pause the simulation and move around the cube with keyboard controls to see how it was counting the neighbors.

To pause the simulation and view the neighbor visualization, hit the space key.  This will stop the simulation, but you'll still be able to move the cube around on screen. To move the current town, you can move side to side with the 'a' and 'd' keys, up and down with the 'w' and 'd' keys, and in and out with the 'q' and 'e' keys.  To resume the simulation, just hit space again.  The current town will be a white square while the neighbors will be a bright blue square.  The white square will be solid if the town is alive and less opaque if the town is dead.  The same goes for the neighbors.  If the neighbor is alive, it will be a solid blue square, otherwise it will be a blue wireframe.  
