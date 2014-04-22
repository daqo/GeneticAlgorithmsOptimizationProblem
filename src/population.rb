require_relative 'float_utility'

class Population
  attr_accessor :chromosomes

  TOURNAMENT_NUM = 2

  MIN_RANGE = -2
  MAX_RANGE = 2

  def initialize
    self.chromosomes = Array.new
  end

  def print_fitness_values
    vals = chromosomes.map(&:fitness)
    chromosomes.each_with_index do |c, i|
      puts "Chromosome: #{c}, Fitness: #{vals[i]}"
    end
  end

  def inspect
    fitnesses = {}
    chromosomes.each do |chromosome|
      fitnesses[chromosome.genes] = chromosome.fitness
    end

    key = fitnesses.min_by{|k,v| v}[0]
    max_fitness = fitnesses[key]
    x, y = FloatUtility.decode_gene(key, MIN_RANGE, MAX_RANGE)
    puts "#{x},#{y} : #{max_fitness}"
  end

  def seed!
    chromosomes = Array.new
    1.upto(POPULATION_SIZE).each do
      chromosomes << Chromosome.new
    end

    self.chromosomes = chromosomes
  end

  def size
    self.chromosomes.size
  end

  def tournament_select
      best = nil
      TOURNAMENT_NUM.times do
        selected_citizen = self.chromosomes[rand(POPULATION_SIZE)]
        if (best == nil) or selected_citizen.fitness < best.fitness
          best = selected_citizen 
        end
      end
      return best
  end
end
