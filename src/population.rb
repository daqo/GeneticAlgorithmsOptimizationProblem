require_relative 'float_utility'

class Population
  attr_accessor :chromosomes

  TOURNAMENT_NUM = 2

  MIN_RANGE = -2
  MAX_RANGE = 2
  NUM_BITS_FLOATS = 32

  def initialize
    self.chromosomes = Array.new
  end

  def print_fitness_values
    vals = chromosomes.map(&:fitness)
    chromosomes.each_with_index do |c, i|
      puts "Chromosome: #{c}, #{vals[i]}"
    end
  end

  def inspect
    #chromosomes.join(" ")
    fitnesses = {}
    chromosomes.each do |chromosome|
      fitnesses[chromosome.genes] = chromosome.fitness
    end

    key = fitnesses.min_by{|k,v| v}[0]
    max_fitness = fitnesses[key]
    x, y = FloatUtility.decode_gene(key, NUM_BITS_FLOATS, MIN_RANGE, MAX_RANGE)
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

  # def fitness_values
  #   vals = chromosomes.collect(&:fitness)
  #   vals.each_with_index do |v, i|
  #     puts "Chromosome: #{chromosomes[i]}, Fitness: #{vals[i]}"
  #   end
  #   vals
  # end

  def tournament_select
      best = nil
      TOURNAMENT_NUM.times do
        selected_citizen = self.chromosomes[rand(POPULATION_SIZE)]
        best = selected_citizen if (best == nil) or selected_citizen.fitness < best.fitness
      end
      return best
  end
end
