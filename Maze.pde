// Matthew Bardoe
// This code is derived from Code by Dan Shiffman
// at 
// http://codingtra.in
// http://patreon.com/codingtrain
// Much of this code was in a setup and draw sketch
// Now it has been placed in a wrapper object to
// support serialization.


class Maze {

  ArrayList<Cell> grid = new ArrayList<Cell>();
  int cols, rows;
  int w;

  Maze(int ww) {
    w=ww;
    cols = floor(width/w);
    rows = floor(height/w);
    for (int j = 0; j < rows; j++) {
      for (int i = 0; i < cols; i++) {
        Cell cell = new Cell(i, j);
        grid.add(cell);
      }
    }
  }

  Maze(JSONObject json) {
    deSerialize(json);
  }
  
  Maze(String filename){
    JSONObject json=loadJSONObject(filename);
    deSerialize(json);
  }
  
  void deSerialize(JSONObject json){
    w=json.getInt("w");
    cols=json.getInt("cols");
    rows=json.getInt("rows");
    JSONArray jsonWalls=json.getJSONArray("walls");
    for (int i=0; i<cols*rows; i++) {
      JSONObject jsonCell=jsonWalls.getJSONObject(i);
      Cell cell= new Cell(jsonCell);
      grid.add(cell);
    }
  }
    



  JSONObject serialize() {
    JSONObject json = new JSONObject();
    json.setInt("w", w);
    json.setInt("cols", cols);
    json.setInt("rows", rows);
    JSONArray jsonWalls = new JSONArray();
    for (int i = 0; i < grid.size(); i++) {
      Cell currentCell=grid.get(i);
      JSONObject jsonCell=currentCell.serialize();
      jsonWalls.setJSONObject(i, jsonCell);
    }
    json.setJSONArray("grid", jsonWalls);
    return json;
  } 

  void save(String filename) {
    saveJSONObject(serialize(), filename);
  }

  void generate() {
    ArrayList<Cell> stack = new ArrayList<Cell>();

    Cell current = grid.get(0);
    Boolean flag=true;
    while (flag) {
      current.visited = true;
      //current.highlight();
      // STEP 1
      Cell next = checkNeighbors(current);
      if (next != null) {
        next.visited = true;

        // STEP 2
        stack.add(current);

        // STEP 3
        removeWalls(current, next);

        // STEP 4
        current = next;
      } else if (stack.size() > 0) {
        current = stack.remove(stack.size()-1);
      } else {
        flag=false;
      }
    }
  }


  void show() {
    for (int i = 0; i < grid.size(); i++) {
      grid.get(i).show(w);
    }
  }


  int index(int i, int j) {
    if (i < 0 || j < 0 || i > cols-1 || j > rows-1) {
      return 0;
    }
    return i + j * cols;
  }


  void removeWalls(Cell a, Cell b) {
    int x = a.i - b.i;
    if (x == 1) {
      a.walls[3] = false;
      b.walls[1] = false;
    } else if (x == -1) {
      a.walls[1] = false;
      b.walls[3] = false;
    }
    int y = a.j - b.j;
    if (y == 1) {
      a.walls[0] = false;
      b.walls[2] = false;
    } else if (y == -1) {
      a.walls[2] = false;
      b.walls[0] = false;
    }
  }
  Cell checkNeighbors(Cell current) {
    ArrayList<Cell> neighbors = new ArrayList<Cell>();

    Cell top    = grid.get(index(current.i, current.j-1));
    Cell right  = grid.get(index(current.i+1, current.j));
    Cell bottom = grid.get(index(current.i, current.j+1));
    Cell left   = grid.get(index(current.i-1, current.j));

    if (top != null && !top.visited) {
      neighbors.add(top);
    }
    if (right != null && !right.visited) {
      neighbors.add(right);
    }
    if (bottom != null && !bottom.visited) {
      neighbors.add(bottom);
    }
    if (left != null && !left.visited) {
      neighbors.add(left);
    }

    if (neighbors.size() > 0) {
      int r = floor(random(0, neighbors.size()));
      return neighbors.get(r);
    } else {
      return null;
    }
  }
}
