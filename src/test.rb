require_relative 'chromosome'
require_relative 'population'

POPULATION_SIZE = 2000
NUM_GENERATIONS = 100
CROSSOVER_RATE = 0.7
MUTATION_RATE = 0.01


population = Population.new
population.seed!

NUM_GENERATIONS.times do |generation|
  offspring = Population.new

  population.print_fitness_values

  while offspring.size < population.size
    parent1 = population.tournament_select
    parent2 = population.tournament_select

    if rand <= CROSSOVER_RATE
      child1, child2 = parent1 & parent2
    else
      child1 = parent1
      child2 = parent2
    end

    child1.mutate!
    child2.mutate!

    if POPULATION_SIZE.even?
      offspring.chromosomes << child1 << child2
    else
      offspring.chromosomes << [child1, child2].sample
    end
  end

  population = offspring
end

population.inspect