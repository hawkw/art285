List<Node> roots;

void setup() {
  colorMode(HSB);
  size(1000, 800);
  smooth();
  //frameRate(10);
  roots = new ArrayList<Node>();
}

void draw() {
  strokeWeight(2);
  for (Node root: roots) {
    pushMatrix();
      translate(root.x, root.y);
      //print("x: " + root.x + " y: " + root.y + "\n");
      root.draw();
      root.do_update();
    popMatrix();
  }
}

void mouseClicked() {
  //  print("x: " + mouseX + " y: " + mouseY + "\n");
   roots.add(new Node( 0, 0
                     , mouseX, mouseY
                     , color( map(mouseX, 0, width, 0, 360)
                            , map(mouseY, 0, height, 0, 255)
                            , 255
                            )
                     ));
}
