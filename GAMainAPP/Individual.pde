public class Individual 
{
    int[] genome;
    int genomeSize;
    float fitness;
    Bunch bunch;

    Individual(int genomeSize, Bunch bunch) {
        this.genomeSize = genomeSize;
        this.bunch = bunch;
        genome = new int[genomeSize];

        // Initialize the genome with a random permutation
        ArrayList<Integer> indices = new ArrayList<>();
        for (int i = 0; i < genomeSize; i++) {
            indices.add(i);
        }
        Collections.shuffle(indices);
        for (int i = 0; i < genomeSize; i++) {
            genome[i] = indices.get(i);
        }
    }

    Individual(int[] genes, Bunch bunch) {
        this.genomeSize = genes.length;
        this.bunch = bunch;
        genome = Arrays.copyOf(genes, genes.length);
    }

    Individual crossover(Individual partner) {
        Individual child = new Individual(genomeSize, bunch);
        int crossoverPoint = (int) random(genomeSize);

        System.arraycopy(genome, 0, child.genome, 0, crossoverPoint);

        int index = crossoverPoint;
        for (int gene : partner.genome) {
            boolean alreadyPresent = false;
            for (int j = 0; j < crossoverPoint; j++) {
                if (child.genome[j] == gene) {
                    alreadyPresent = true;
                    break;
                }
            }
            if (!alreadyPresent) {
                child.genome[index++] = gene;
            }
        }

        return child;
    }

    void mutate(float mutationRate) {
        if (random(1) < mutationRate) {
            int point1 = (int) random(0, genomeSize);
            int point2 = (int) random(0, genomeSize);
            int temp = genome[point1];
            genome[point1] = genome[point2];
            genome[point2] = temp;
        }
    }

    void evaluateIndividual() {
        int[] radii = new int[bunch.numCircles];
        for (int i = 0; i < bunch.numCircles; i++) {
            radii[i] = bunch.Circles[i].radius;
        }
        Bunch tmpBunch = new Bunch(radii);
        tmpBunch.orderedPlace(genome);
        float boundary = tmpBunch.computeBoundary();
        fitness = -boundary; 
    }
}
