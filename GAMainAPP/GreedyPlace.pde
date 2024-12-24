class GreedyPlace 
{
  int[] radii;
  Bunch greedyCircles;
  int[] initialOrder;

  GreedyPlace(int[] inRad, int[] inOrder) {
    radii = Arrays.copyOf(inRad, inRad.length);
    initialOrder = Arrays.copyOf(inOrder, inOrder.length);
    greedyCircles = new Bunch(radii);
  }

  int[] getGreedyOrder(int[] initialOrder) {
    int[] order = Arrays.copyOf(initialOrder, initialOrder.length);
    boolean[] placed = new boolean[radii.length];
    Arrays.fill(placed, false);

    placed[order[0]] = true;

    for (int i = 1; i < radii.length; i++) {
      int next = -1;
      float minIncrease = Float.MAX_VALUE;

      for (int j = 0; j < radii.length; j++) {
        if (placed[j]) continue;

        order[i] = j;
        Bunch tmpBunch = new Bunch(radii);
        tmpBunch.orderedPlace(order);

        float boundary = tmpBunch.computeBoundary();
        if (boundary < minIncrease) {
          minIncrease = boundary;
          next = j;
        }
      }

      order[i] = next;
      placed[next] = true;
    }

    return order;
  }
    float greedyPlacement() {
    int[] order = getGreedyOrder(initialOrder);

    Bunch tmpBunch = new Bunch(radii);
    tmpBunch.orderedPlace(order);

    // save it
    greedyCircles = tmpBunch;

    // assess it
    return tmpBunch.computeBoundary();
  }
  
  void draw() {
    greedyCircles.draw();
  }
}
