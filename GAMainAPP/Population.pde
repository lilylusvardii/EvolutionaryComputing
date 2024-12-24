public class Population 
{
    boolean finished;
    Individual solution;
    float current_best;
    int evals;
    int max_gens;
    int popsize;
    float mutation_rate;
    int current_gen;


    Individual[] individuals;
    Bunch bunch;

    Population(int size, int maxgens, float mut, Bunch bunch) {
        popsize = size;
        mutation_rate = mut;
        evals = 0;
        max_gens = maxgens;
        finished = false;
        this.bunch = bunch;
        individuals = new Individual[popsize];
        current_best = -Float.MAX_VALUE;
        current_gen = 0;


        for (int i = 0; i < popsize; i++) {
            individuals[i] = new Individual(bunch.numCircles, bunch);
        }
    }

    Individual get_solution() {
        return solution;
    }

    void evolve(int gen) {
        if (gen > max_gens) { //gen
            finished = true;
        } else {
            // calculate fitnesses 
            float generation_best_fitness = -Float.MAX_VALUE;
            float generation_worst_fitness = Float.MAX_VALUE;
            for (int poploop = 0; poploop < popsize; poploop++) {
                evals++;
                individuals[poploop].evaluateIndividual();
                if (individuals[poploop].fitness > generation_best_fitness) {
                    generation_best_fitness = individuals[poploop].fitness;
                }
                if (individuals[poploop].fitness < generation_worst_fitness) {
                    generation_worst_fitness = individuals[poploop].fitness;
                }
                if (individuals[poploop].fitness > current_best) {
                    current_best = individuals[poploop].fitness;
                    solution = individuals[poploop];
                }
            }

            //println("generation " + current_gen + " best " + generation_best_fitness);
            //println("generation " + current_gen + " worst " + generation_worst_fitness);
        }

        if (!finished) {
            ArrayList<Individual> matingPool = new ArrayList<>();

            for (int i = 0; i < popsize; i++) {
                matingPool.add(tournamentSelection());
            }

            for (int i = 0; i < popsize; i++) {
                int a = (int) random(matingPool.size());
                int b = (int) random(matingPool.size());
                Individual partnerA = matingPool.get(a);
                Individual partnerB = matingPool.get(b);
                Individual child = partnerA.crossover(partnerB);
                child.mutate(mutation_rate);
                individuals[i] = child;
            }
        }
        //current_gen++; 
    }

    Individual tournamentSelection() {
        int tournamentSize = 5; // tournament size
        Individual best = null;
        for (int i = 0; i < tournamentSize; i++) {
            int randomIndex = (int) (Math.random() * popsize);
            Individual candidate = individuals[randomIndex];
            if (best == null || candidate.fitness > best.fitness) {
                best = candidate;
            }
        }
        return best;
    }
}
    
