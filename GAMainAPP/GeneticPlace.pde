class GeneticPlace 
{
    int[] radii;
    Population population;
    int generations;
    Bunch bunch;

    GeneticPlace(int[] radii,int [] order, int popSize, int maxGens, float mutationRate) {
        this.radii = radii;
        this.bunch = new Bunch(radii);
        this.population = new Population(popSize, maxGens, mutationRate, bunch);
        this.generations = maxGens;
    }

    float geneticPlacement() {
        for (int gen = 0; gen < generations; gen++) {
            population.evolve(gen);
            if (population.finished) break;
        }
        Individual best = population.get_solution();
        bunch.orderedPlace(best.genome);
        return -best.fitness; 
    }

    void draw() {
        bunch.orderedPlace(population.get_solution().genome);
        bunch.draw();
    }
}

  
