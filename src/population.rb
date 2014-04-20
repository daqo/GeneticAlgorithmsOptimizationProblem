class Population
  attr_accessor :chromosomes

  TOURNAMENT_SIZE = 2

  def initialize
    self.chromosomes = Array.new
  end

  def inspect
    chromosomes.join(" ")
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

  def fitness_values
    vals = chromosomes.collect(&:fitness)
    vals.each_with_index do |v, i|
      puts "#{chromosomes[i]}: #{vals[i]}"
    end
    vals
  end

  # def total_fitness
  #   fitness_values.inject{|total, value| total + value }
  # end

  # def max_fitness
  #   fitness_values.max
  # end

  # def average_fitness
  #   total_fitness.to_f / chromosomes.length.to_f
  # end

  # def select
  #   rand_selection = rand(total_fitness)

  #   total = 0
  #   chromosomes.each_with_index do |chromosome, index|
  #     total += chromosome.fitness
  #     return chromosome if total > rand_selection || index == chromosomes.count - 1
  #   end
  # end


  def tournament_select
      best = nil
      1.upto(TOURNAMENT_SIZE) do
        selected_citizen = self.chromosomes[rand(POPULATION_SIZE)]
        best = selected_citizen if (best == nil) or selected_citizen.fitness < best.fitness
      end
      return best
  end
end
