class RandomPlace 
{
  int[] radii;
  Bunch randomCircles;
  int[] order;

  RandomPlace(int[] inRad, int[] inOrder) {
    radii = new int[inRad.length];
    for (int i = 0; i < inRad.length; i++) {
      radii[i] = inRad[i];
    }
    
    order = new int[inOrder.length];
    for (int i = 0; i < inOrder.length; i++) {
      order[i] = inOrder[i];
    }

    //println("Created new RandomPlace:");
    //System.out.println(Arrays.toString(radii));
    //System.out.println(Arrays.toString(order));
  }

  float randomPlacement() {
    // shuffle the order array
    int[] orderCopy = Arrays.copyOf(order, order.length);
    Random rand = new Random();
    
    for (int i = 0; i < orderCopy.length; i++) {
      int randomIndex = rand.nextInt(orderCopy.length);
      int temp = orderCopy[randomIndex];
      orderCopy[randomIndex] = orderCopy[i];
      orderCopy[i] = temp;
    }
    
    //println("Shuffled order:");
    //System.out.println(Arrays.toString(orderCopy));
    
    // create a new Bunch object 
    Bunch tmpBunch = new Bunch(radii);
    
    // place the circles with the shuffled ordering
    tmpBunch.orderedPlace(orderCopy);
    
    // save it
    randomCircles = tmpBunch;
    
    // assess it
    return tmpBunch.computeBoundary();
  }
  void draw() {
    randomCircles.draw();
  }
}
