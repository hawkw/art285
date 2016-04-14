import java.util.List;
import java.util.ArrayList;

final int NODE_DIAM = 13;
final int BRANCH_LEN = 75;
final float VARIANCE = 50;


class Node {
  //PVector theta;
  float theta, x, y;
  List<Node> children;
  int generation;
  color myColor;

  Node child() {
    return new Node ( generation == 0 ? random(0, 360)
                                      : random(-VARIANCE, VARIANCE)
                    , generation + 1
                    , 0, 0
                    , myColor);
  }

  Node(float theta, int generation, float x, float y, color myColor) {
    this.x = x;
    this.y = y;
    this.theta = radians(theta);
    this.children = new ArrayList<Node>();
    this.generation = generation;
    this.myColor = myColor;
  }


  void draw() {
      for (Node child: children) {
        pushMatrix();
          stroke(myColor);
          rotate(child.theta);
          line(0, 0, BRANCH_LEN, BRANCH_LEN);
          translate(BRANCH_LEN, BRANCH_LEN);
          child.draw();
        popMatrix();
      }
      ellipse(0, 0, NODE_DIAM, NODE_DIAM);
  }

  void do_update() {
    for (Node child: children) {
      child.do_update();
    }
    if ((random(0, 50) - (generation * 20)) > (children.size() * 10)) {
      children.add(child());
    }


  }
}
