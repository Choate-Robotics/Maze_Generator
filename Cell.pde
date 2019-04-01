// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Matthew Bardoe
// Added support for saving and serialization. 
// Utilizes a Maze object to hold the Cells. 
// Videos
// https://youtu.be/HyK_Q5rrcr4
// https://youtu.be/D8UgRyRnvXU
// https://youtu.be/8Ju_uxJ9v44
// https://youtu.be/_p5IH0L63wo

// Depth-first search
// Recursive backtracker
// https://en.wikipedia.org/wiki/Maze_generation_algorithm

class Cell {
  int i, j;
  boolean[] walls = {true, true, true, true};
  boolean visited = false;
  
  Cell(int ii, int jj) {
    i = ii;
    j = jj;
  }
  
  
  Cell(JSONObject json){
    i=json.getInt("i");
    j=json.getInt("j");
    JSONArray jsonWalls = json.getJSONArray("walls");
    for (int a=0; a<walls.length; a++){
      walls[a]=jsonWalls.getBoolean(a);
    }
  }

  
  //void highlight() {
  //  int x = this.i*w;
  //  int y = this.j*w;
  //  noStroke();
  //  fill(0, 0, 255, 100);
  //  rect(x, y, w, w);

  //}

  void show(int w) {
    int x = this.i*w;
    int y = this.j*w;
    stroke(255);
    if (this.walls[0]) {
      line(x    , y    , x + w, y);
    }
    if (this.walls[1]) {
      line(x + w, y    , x + w, y + w);
    }
    if (this.walls[2]) {
      line(x + w, y + w, x    , y + w);
    }
    if (this.walls[3]) {
      line(x    , y + w, x    , y);
    }

    if (this.visited) {
      noStroke();
      fill(255, 0, 255, 100);
      rect(x, y, w, w);
    }
  }
  
  JSONObject serialize(){
    JSONObject json = new JSONObject();

    json.setInt("i", i);
    json.setInt("j", j);
    JSONArray JSONwalls=new JSONArray();
    for (int a=0; a<walls.length;a++){
      JSONwalls.setBoolean(a,walls[a]);
    }
      
    json.setJSONArray("walls",JSONwalls);
    return json;
  }
  
  void save(String filename){
      saveJSONObject(serialize(), filename);
  }
  
  
}
