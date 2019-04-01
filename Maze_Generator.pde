// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Matthew Bardoe
// Updated to create a Maze object that
// can be serialized. So that the Mazes can be
// saved and stored.
// Videos
// https://youtu.be/HyK_Q5rrcr4
// https://youtu.be/D8UgRyRnvXU
// https://youtu.be/8Ju_uxJ9v44
// https://youtu.be/_p5IH0L63wo

// Depth-first search
// Recursive backtracker
// https://en.wikipedia.org/wiki/Maze_generation_algorithm


Maze m;

void setup() {
  size(640, 640);
  //You can generate and save a maze.
  //m= new Maze(80);
  //m.generate();
  //m.save("data/maze1.json");
  // Or you can load a previously generated maze.
  m = new Maze("data/maze1.json");
}

void draw() {
  background(51);
  m.show();
}
