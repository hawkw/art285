import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.List; 
import java.util.ArrayList; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class constellate extends PApplet {

List<Node> roots;

public void setup() {
  colorMode(HSB);
  
  
  //frameRate(10);
  roots = new ArrayList<Node>();
}

public void draw() {
  for (Node root: roots) {
    pushMatrix();
      translate(root.x, root.y);
      //print("x: " + root.x + " y: " + root.y + "\n");
      root.draw();
      root.do_update();
    popMatrix();
  }
}

public void mouseClicked() {
   print("x: " + mouseX + " y: " + mouseY + "\n");
   roots.add(new Node( 0, 0
                     , mouseX, mouseY
                     , color( map(mouseX, 0, width, 0, 360)
                            , map(mouseY, 0, height, 0, 255)
                            , 255
                            )
                     ));
}



final int NODE_DIAM = 10;
final int BRANCH_LEN = 75;
final float VARIANCE = 50;


class Node {
  //PVector theta;
  float theta, x, y;
  List<Node> children;
  int generation;
  int myColor;
  
  public Node child() {
    return new Node ( generation == 0 ? random(0, 360) 
                                      : random(-VARIANCE, VARIANCE)
                    , generation + 1
                    , 0, 0
                    , myColor);
  }
 
  Node(float theta, int generation, float x, float y, int myColor) {
    this.x = x;
    this.y = y;
    this.theta = radians(theta);
    this.children = new ArrayList<Node>();
    this.generation = generation;
    this.myColor = myColor;
  }
  

  public void draw() {
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
  
  public void do_update() {
    for (Node child: children) {
      child.do_update();
    }
    if ((random(0, 50) - (generation * 20)) > (children.size() * 10)) {
      children.add(child());
    }
      
  
  }
}
  public void settings() {  size(1000, 800);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "constellate" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
