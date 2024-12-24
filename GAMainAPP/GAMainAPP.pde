import java.util.Arrays; 
import java.util.Collections;
import java.util.List;
import java.util.Random;

// object (class instance) for each algorithm used
RandomPlace[] randomAlg;
GreedyPlace[] greedyAlg; 
GeneticPlace[] geneticAlg; 
//for the key pressed
int currentAlgorithm = 0; 
int currentInstance = 0;
int[] algorithms = {0,1,2}; 

// width and height of screen
int w = 800;
int h = 600;

// determine centre point of screen
int cx = w / 2; // always width/2
int cy = h / 2; // always height/2

PFont f;

int[][]instances = {
    {10,12,15,20,21,30,30,30,50,40},//r1, instance 1
    {10,40,25,15,18},//r2, instance 2
    {10,34,10,55,30,14,70,14},//r3, instance 3
    {5,50,50,50,50,50,50},//r4, instance 4
    {10,34,10,55,30,14,70,14,50,16,23,76,34,10,12,15,16,11,48,20},//r5, instance 5
    {20,22,17,17,7,21,11,5,23,8},//t1, instance 6
    {8,14,8,15,11,17,21,16,6,18,24,13,20,10},//t2, instance 7
    {24, 16, 19, 7, 14, 24, 15, 6, 16, 16, 23, 10, 9, 10, 18, 22, 7, 9, 7, 13, 14, 8, 18, 6, 8},//t3, instance 8
    {6,12,20,6,14,19,9,20,10,13,12,14,23,17,16,19,15,10,12,18,21,6,20,17,13,20,17,6,21,15,12,9,14,20,23,16,23,9,23,18},//t4, instance 9
    {17,23,17,13,18,21,23,22,7,9,8,13,20,11,10,19,10,14,12,22,19,10,17,11,21,8,15,16,19,21,17,19,8,6,13,13,14,19,18,23,20,24,24,13,13,19,7,6,10,8,8,10,24,19,24}//t5, instance 10
};

void setup() {
  noLoop();
  size(800, 600);
  f = createFont("Arial", 16, true);
  
  randomAlg= new RandomPlace[instances.length];
  greedyAlg = new GreedyPlace[instances.length];
  geneticAlg = new GeneticPlace[instances.length];
  
  for (int i = 0; i < instances.length; i++) {
    int[] radii = instances[i];
    int[] order = new int[radii.length];
    for (int j = 0; j < order.length; j++) {
      order[j] = j;
    }
  
    println("ordering: " + Arrays.toString(order));
    
    geneticAlg[i] = new GeneticPlace(radii, order, 200, 100, 0.02);
    float gaBoundary = geneticAlg[i].geneticPlacement();
    println("Instance " + (i + 1) + ", GA bounding circle radius: " + gaBoundary);
    
    greedyAlg[i] = new GreedyPlace(radii, order);
    float grBoundary = greedyAlg[i].greedyPlacement();
    println("Instance " + (i + 1) + ", Greedy bounding circle radius: " + grBoundary);
    
    randomAlg[i] = new RandomPlace(radii, order);
    float raBoundary = randomAlg[i].randomPlacement();
    println("Instance " + (i + 1) + ", Random bounding circle radius: " + raBoundary);

    //orderedAlg[i] = new OCPlace(radii, order, 200, 100, 0.01);
    //float ocBoundary = orderedAlg[i].orderedCrossoverPlacement();
    //println("Instance " + (i + 1) + ", Ordered Crossover bounding circle radius: " + ocBoundary);
  }
  
}

void draw() {
  background(255);
  if (currentAlgorithm == 0) {
    float boundary = geneticAlg[currentInstance].geneticPlacement();
    println("genetic placement gives boundary of " + boundary);
    geneticAlg[currentInstance].draw();
    fill(0);
    textFont(f, 16);
    text("GENETIC PLACEMENT INSTANCE " + (currentInstance + 1), 50, 20);
    text("use 'f' and 'b' keys to navigate through this algorithms instances",50, 40);
    text("use 'u' and 'd' keys to navigate through algorithms", 50, 60);
    text("bounding circle radius: " + boundary, 50, 80);
  } 
    else if (currentAlgorithm == 1) {
    float boundary = greedyAlg[currentInstance].greedyPlacement();
    println("greedy placement gives boundary of " + boundary);
    greedyAlg[currentInstance].draw();
    fill(0);
    textFont(f, 16);
    text("GREEDY PLACEMENT INSTANCE " + (currentInstance + 1), 50, 20);
    text("use 'f' and 'b' keys to navigate through this algorithms instances",50, 40);
    text("use 'u' and 'd' keys to navigate through algorithms", 50, 60);
    text("bounding circle radius: " + boundary, 50, 80);
  } 
    else if (currentAlgorithm == 2) {
    float boundary = randomAlg[currentInstance].randomPlacement();
    println("random gives boundary of " + boundary);
    randomAlg[currentInstance].draw();
    fill(0);
    textFont(f, 16);
    text("RANDOM PLACEMENT INSTANCE " + (currentInstance + 1), 50, 20);
    text("use 'f' and 'b' keys to navigate through this algorithms instances",50, 40);
    text("use 'u' and 'd' keys to navigate through algorithms", 50, 60);
    text("bounding circle radius: " + boundary, 50, 80);
   }
}

void keyPressed() { // works but is slow at going through
  if (key == 'u') {
    currentAlgorithm = (currentAlgorithm + 1) % algorithms.length;
    redraw();
  }
  if (key == 'd') {
    currentAlgorithm = (currentAlgorithm - 1 + algorithms.length) % algorithms.length;
    redraw();
  }
  if (key == 'f') {
    currentInstance = (currentInstance + 1) % instances.length;
    redraw();
  }
  if (key == 'b') {
    currentInstance = (currentInstance - 1 + instances.length) % instances.length;
    redraw();
  }
}
