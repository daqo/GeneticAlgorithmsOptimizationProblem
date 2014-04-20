require_relative 'float_utility'
require_relative 'chromosome'
require_relative 'population'

POPULATION_SIZE = 2000
NUM_GENERATIONS = 1000
CROSSOVER_RATE = 0.7
MUTATION_RATE = 0.01

MIN_RANGE = -2
MAX_RANGE = 2
NUM_BITS_FLOATS = 32

population = Population.new
population.seed!

1.upto(NUM_GENERATIONS).each do |generation|
  fitness_values_of_population = population.fitness_values

  offspring = Population.new

  while offspring.size < population.size
    parent1 = population.tournament_select
    parent2 = population.tournament_select

    if rand <= CROSSOVER_RATE
      child1, child2 = parent1 & parent2
    else
      child1 = parent1
      child2 = parent2
    end

    #child1.mutate!
    #child2.mutate!

    if POPULATION_SIZE.even?
      offspring.chromosomes << child1 << child2
    else
      offspring.chromosomes << [child1, child2].sample
    end
  end

  #puts "Generation #{generation} - Average: #{population.average_fitness.round(2)} - Max: #{population.max_fitness}"
  population = offspring
end

# puts "Final population: " + population.inspect
population.chromosomes.each do |chromosome|
  strs = FloatUtility.halve(chromosome.genes)
  x = FloatUtility.decode_float(strs[0], NUM_BITS_FLOATS, MIN_RANGE, MAX_RANGE)
  y = FloatUtility.decode_float(strs[1], NUM_BITS_FLOATS, MIN_RANGE, MAX_RANGE)
  puts "x: #{x}, y:#{y}"
end