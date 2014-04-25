import oscP5.*;
import netP5.*;

OscP5 oscP5;

int radii = 3;
int maxRadius;
int segments = radii * 2;
float baseAngularVelocity = TWO_PI / 64;
float[] angles = new float[radii];
float[] angularVelocities = new float[radii];
color colors[] = new color[radii];

float segmentAngle = TWO_PI / segments;

void setup() {
    size(displayWidth, displayHeight);
    maxRadius = height;
//    size(800, 800);
    smooth();
    colorMode(HSB);
    rectMode(CENTER);
    noStroke();

    for (int i=0; i<radii; i++) {
        angles[i] = 0;
        angularVelocities[radii - i - 1] = baseAngularVelocity / (i + 1);
        colors[i] = randomColor();
    }

    oscP5 = new OscP5(this, 12000);
}

color randomColor() {
    return color(random(255), 255, 255);
}

void draw() {
    background(0);

    translate(width/2, height/2);

    float radius = maxRadius;

    for (int i=0; i<radii; i++) {
        pushMatrix();
        rotate(angles[i]);
        for (int j=0; j<segments; j++) {
            fill(colors[j % radii]);
            rotate(segmentAngle);
            arc(0, 0, radius, radius, 0, segmentAngle);
        }
        popMatrix();
        radius -= maxRadius / radii;
        angles[i] += angularVelocities[i];
    }
}

void oscEvent(OscMessage message) {
    int beat = message.get(0).intValue();
    colors[beat] = randomColor();
}

