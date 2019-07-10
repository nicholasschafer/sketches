// Generates album art and header image for https://whaleexist.bandcamp.com/album/expectancy-effect

// Cover properties
int width = 1600;
int height = 1600;
int centerX = width / 2;
int centerY = height / 2;
int padding = 80;

String name = "Band Name";
String title = "Album Name";

int[] durations = {574, 324, 284}; // seconds
float[] radii = {};

color background = color(114, 122, 124);
color primary = color(26, 53, 96, 80);
color line = color(26, 53, 96, 30);

PFont font;

// Header properties
int headerWidth = 975;
int headerHeight = 60;
int headerCenterX = headerWidth / 2;
int headerCenterY = headerHeight / 2;
int headerPadding = 30;
int headerTopPadding = 28;
int headerBarHeight = 20;

PGraphics headerImage;

void settings() {
  size(width, height);
}

void setup() {
  noLoop();
  strokeWeight(1);

  font = createFont("LucidaSans", 18);
  textFont(font);

  headerImage = createGraphics(headerWidth, headerHeight);
}

void draw() {
  textAlign(LEFT);

  float maxDuration = max(durations);
  background(background);
  drawNoise();

  pushMatrix();

  translate(centerX, centerY);
  blendMode(MULTIPLY);
  
  for (int duration : durations) {
    float outerRadius = ((duration / maxDuration) * (width - (padding * 2))) / 2;
    float innerRadius = outerRadius / 3;
    radii = append(radii, outerRadius);
    radii = append(radii, innerRadius);
    drawRing(60, outerRadius, innerRadius);
  }

  for (float radius : radii) {
    drawLines(60, radius);
  }

  blendMode(BLEND);
  popMatrix();

  fill(200);
  text(name.toUpperCase(), padding, padding + 4);
  textAlign(RIGHT);
  text(title.toUpperCase(), width - padding, padding + 4);

  save("cover-" + year() +  month() + day() + "-" + hour() + minute() + second() + ".png");

  drawHeader();
}

void drawNoise() {
  strokeWeight(1);
  int i = 0;
  while (i < width) {
    int j = 0;
    while (j < height) {
      float distance = dist(centerX, centerY, i, j);
      stroke(0, random(0, 60) * ((distance + 100) / width));
      point(i, j);
      j++;
    }
    i++;
  }
}

void drawRing(int sides, float outerRadius, float innerRadius) {
  float angle = 360 / sides;
  int millis = millis();
  noStroke();
  fill(primary);
  beginShape();
  for (int i = 0; i <= sides; i++) {
    float offset = noise(i * 0.2 + millis) * (outerRadius / 20);
    float x = cos(radians(i * angle)) * outerRadius;
    float y = sin(radians(i * angle)) * outerRadius;
    vertex(x, y);
  }
  for (int i = sides + 1; i >= 0; i--) {
    float x = cos(radians(i * angle)) * innerRadius;
    float y = sin(radians(i * angle)) * innerRadius;
    vertex(x, y);
  }
  endShape();
}

void drawLines(int sides, float radius) {
  float angle = 360 / sides;

  noFill();
  stroke(line);
  
  int loops = 0;
  while (loops < 6) {
    int millis = millis();
    beginShape();
    for (int i = 0; i < sides; i++) {
      float offset = noise(i * 0.2 + millis) * (radius / 10);
      float multiplier = loops < 3 ? radius - offset : radius + offset;
      float x = cos(radians(i * angle)) * multiplier;
      float y = sin(radians(i * angle)) * multiplier;
      curveVertex(x, y);
    }
    endShape(CLOSE);
    loops++;
  }
}

void drawHeader() {
  headerImage.beginDraw();
  headerImage.noStroke();
  headerImage.fill(background); 
  headerImage.rect(headerPadding, headerTopPadding, headerWidth - (headerPadding * 2), headerBarHeight);
  headerImage.blendMode(MULTIPLY);
  headerImage.fill(primary);
  headerImage.rect(headerPadding, headerTopPadding, headerWidth - (headerPadding * 2), headerBarHeight);

  headerImage.strokeWeight(1);
  int i = headerPadding;
  while (i < headerWidth - headerPadding) {
    int j = headerTopPadding;
    while (j < headerTopPadding + headerBarHeight) {
      float distance = dist(headerCenterX, headerCenterY, i, j);
      headerImage.stroke(0, random(0, 60) * ((distance + 100) / headerWidth));
      headerImage.point(i, j);
      j++;
    }
    i++;
  }

  headerImage.endDraw();
  headerImage.save("header-" + year() +  month() + day() + "-" + hour() + minute() + second() + ".png");
}
