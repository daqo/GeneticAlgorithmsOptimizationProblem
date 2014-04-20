require_relative 'float_utility'

class Chromosome

  attr_accessor :genes

  MIN_RANGE = -2
  MAX_RANGE = 2
  NUM_BITS_GENES = 64
  NUM_BITS_FLOATS = 32

  def initialize(genes = "")
    if genes == ""
      initial_x = FloatUtility.random_float_in_range(MIN_RANGE, MAX_RANGE)
      initial_y = FloatUtility.random_float_in_range(MIN_RANGE, MAX_RANGE)
      # puts "x: #{initial_x}, y: #{initial_y}"
      self.genes = FloatUtility.encode_float(initial_x, NUM_BITS_FLOATS, MIN_RANGE, MAX_RANGE) + FloatUtility.encode_float(initial_y, NUM_BITS_FLOATS, MIN_RANGE, MAX_RANGE)
    else
      self.genes = genes
    end
  end

  def to_s
    genes.to_s
  end

  def fitness
    a = FloatUtility.decode_float(self.genes[0..NUM_BITS_FLOATS - 1], NUM_BITS_FLOATS, MIN_RANGE, MAX_RANGE)
    b = FloatUtility.decode_float(self.genes[NUM_BITS_FLOATS, 2 * NUM_BITS_FLOATS - 1], NUM_BITS_FLOATS, MIN_RANGE, MAX_RANGE)
    x = a.to_f
    y = b.to_f

    #return 1.to_f / ((x ** 2) + (y ** 2) + 1)


    return (1 + ((x + y + 1) ** 2) * (19 - 14 * x + 3 * (x ** 2) - 14 * y + 6 * x * y + 3 * (y ** 2))) * (
      ((2 * x - 3 * y) ** 2) *
      (18 - 32 * x + 12 * (x ** 2) + 48 * y - 36 * x * y + 27 * (y ** 2)) +
      30)
  end

  def mutate!
    mutated = ""
    0.upto(genes.length - 1).each do |i|
      allele = genes[i]
      if rand <= MUTATION_RATE
        mutated += (allele == "0") ? "1" : "0"
      else
        mutated += allele
      end
    end

    self.genes = mutated
  end

  def &(other)
    locus = NUM_BITS_FLOATS

    child1 = genes[0, NUM_BITS_FLOATS] + other.genes[locus, NUM_BITS_FLOATS]
    child2 = other.genes[0, NUM_BITS_FLOATS] + genes[locus, NUM_BITS_FLOATS]

    return [Chromosome.new(child1), Chromosome.new(child2)]
  end
end
