final int SPHERE_DIAM = 10;
float m, s, h;

// PShape pyramid;
void setup() {
  size(1000, 800, P3D);
  colorMode(HSB);
  smooth();
  //frameRate(10);
  lights();
  // pyramid = createShape();
  // pyramid.beginShape();
  //   pyramid.vertex(-100, -100, -100);
  //   pyramid.vertex( 100, -100, -100);
  //   pyramid.vertex(   0,    0,  100);
  //
  //   pyramid.vertex( 100, -100, -100);
  //   pyramid.vertex( 100,  100, -100);
  //   pyramid.vertex(   0,    0,  100);
  //
  //   pyramid.vertex( 100, 100, -100);
  //   pyramid.vertex(-100, 100, -100);
  //   pyramid.vertex(   0,   0,  100);
  //
  //   pyramid.vertex(-100,  100, -100);
  //   pyramid.vertex(-100, -100, -100);
  //   pyramid.vertex(   0,    0,  100);
  // pyramid.endShape();
  // pyramid.setStroke(255);
}

final int PYR_BASE = 100;
final int PYR_TICK_START = PYR_BASE + 40;
final int PYR_TICK_END = PYR_TICK_START + 20;
final int PYR_TICK_SMALL_END = PYR_TICK_START + 5;

void pyramid_ticks() {
  pushMatrix();
    translate(0, 0, -PYR_BASE);
    stroke(map(s, 0, S_MAX, 0, 120), 200, 200);
      line(0, PYR_TICK_START, 0, 0, PYR_TICK_END, 0);
      line(0, -PYR_TICK_START, 0, 0, -PYR_TICK_END, 0);
      line(PYR_TICK_START, 0, 0, PYR_TICK_END, 0, 0);
      line(-PYR_TICK_START, 0, 0, -PYR_TICK_END, 0, 0);
      sixty_ticks(PYR_TICK_START + 10);
    stroke(255);
  popMatrix();
}

void sixty_ticks(float rad) {
  beginShape(POINTS);
  for (int a = 0; a < 360; a+=6) {
    float angle = radians(a);
    float x = cos(angle) * rad;
    float y = sin(angle) * rad;
    vertex(x, y);
  }
  endShape();
}

void twentyfour_ticks(float rad) {
  beginShape(POINTS);
  for (int a = 0; a < 360; a+=15) {
    float angle = radians(a);
    float x = cos(angle) * rad;
    float y = sin(angle) * rad;
    vertex(x, y);
  }
  endShape();
}

void pyramid_shape() {
  lights();

  noFill();
  beginShape(TRIANGLE);
    vertex(-PYR_BASE, -PYR_BASE, -PYR_BASE);
    vertex( PYR_BASE, -PYR_BASE, -PYR_BASE);
    vertex(   0,    0,  PYR_BASE);

    vertex( PYR_BASE, -PYR_BASE, -PYR_BASE);
    vertex( PYR_BASE,  PYR_BASE, -PYR_BASE);
    vertex(   0,    0,  PYR_BASE);

    vertex( PYR_BASE, PYR_BASE, -PYR_BASE);
    vertex(-PYR_BASE, PYR_BASE, -PYR_BASE);
    vertex(   0,   0,  PYR_BASE);

    vertex(-PYR_BASE,  PYR_BASE, -PYR_BASE);
    vertex(-PYR_BASE, -PYR_BASE, -PYR_BASE);
    vertex(   0,    0,  PYR_BASE);
  endShape();
}

void pyramid(float theta_x, float theta_z) {
  rotateX(radians(theta_x));
  pushMatrix();
    translate(0, 0, -100);
    pyramid_ticks();
    // shape(pyramid, 0, -50);
    // pyramid.setVisible(true);
    pushMatrix();
      rotateZ(theta_z);
      pyramid_shape();
    popMatrix();
  popMatrix();
}

final float H_MAX = 5182000;
final float M_MAX = 216000;
final float S_MAX = 3600;

void draw() {
  s = (s + 1) % S_MAX;
  m = (m + 1) % M_MAX;
  h = (h + 1) % H_MAX;
  background(0);
  // camera( // eye position
  //         mouseX
  //       , mouseY
  //       , 0
  //         // screen centre position
  //       , width/2
  //       , height/2
  //       , 0
  //         // i don't know what these do, so let's make them random
  //       , 0
  //       , 1
  //       , 0);
  strokeWeight(2);
  translate(width/2, height/2);
  // rotateY(map(mouseY, 0, width, 0, 360));
  // rotateX(map(mouseX, 0, width, 0, 360));
  // float s = map(second(), 0, 60, 0, TWO_PI) - HALF_PI;
  // float m = map(minute() + norm(second(), 0, 60), 0, 60, 0, TWO_PI) - HALF_PI;
  // h = map(hour() + norm(minute(), 0, 60), 0, 24, 0, TWO_PI * 2) - HALF_PI;
  // float sec_theta = radians(i/10);
  stroke(map(h, 0, H_MAX, 240, 360), 200, 200);
  twentyfour_ticks(250);

  pushMatrix();
    rotateX(radians(75));
    stroke(map(m, 0, M_MAX, 120, 240), 200, 200);
    sixty_ticks(250);
  popMatrix();

  stroke(0,0,0);
  rotateX(map(h, 0, H_MAX, 0, TWO_PI) - HALF_PI);
  rotateY(map(m, 0, M_MAX, 0, TWO_PI) - HALF_PI);
  pyramid(0, radians(s/10));
  pyramid(180, radians(s/10));
}
