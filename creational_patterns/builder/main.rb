# frozen_string_literal: true

# The Builder interface specifies methods for creating the different parts of the Product objects.
class Builder
  # @abstract
  def produce_part_a
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  # @abstract
  def produce_part_b
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  # @abstract
  def produce_part_c
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

# The Concrete Builder classes follow the Builder interface and provide specific implementations of the building steps.
class ConcreteBuilder1 < Builder
  def initialize
    reset
  end

  def reset
    @product = Product1.new
  end

  # Concrete Builders are supposed to provide their own methods for retrieving results.
  def product
    product = @product
    reset
    product
  end

  def produce_part_a
    @product.add('PartA1')
  end

  def produce_part_b
    @product.add('PartB1')
  end

  def produce_part_c
    @product.add('PartC1')
  end
end

# It makes sense to use the Builder pattern only when your products are quite complex and require extensive configuration.
class Product1
  def initialize
    @parts = []
  end

  # @param [String] part
  def add(part)
    @parts << part
  end

  def list_parts
    puts "Product parts: #{@parts.join(', ')}"
  end
end

# The Director is only responsible for executing the building steps in a particular sequence.
class Director
  # @return [Builder]
  attr_accessor :builder

  def initialize
    @builder = nil
  end

  # The Director works with any builder instnce that the client code passes to it.
  def builder=(builder)
    @builder = builder
  end

  def build_minimal_viable_product
    @builder.produce_part_a
  end

  def build_full_featured_product
    @builder.produce_part_a
    @builder.produce_part_b
    @builder.produce_part_c
  end
end

# The client code creates a builder object, passes it to the director and then initiates the construction process.

director = Director.new
builder = ConcreteBuilder1.new
director.builder = builder

puts 'Standard basic product:'
director.build_minimal_viable_product
builder.product.list_parts

puts "\n"

puts 'Standard full featured product:'
director.build_full_featured_product
builder.product.list_parts

puts "\n"

# The Builder pattern can be used without a Director class.
puts 'Custom product:'
builder.produce_part_a
builder.produce_part_b
builder.produce_part_c
builder.product.list_parts
