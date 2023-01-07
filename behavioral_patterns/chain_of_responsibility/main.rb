# frozen_string_literal: true

# The Handler interface declares a method for building the chain of handlers. It also declares a method for executing a request.
class Handler
  # @abstract
  # @param [Handler] handler
  def next_handler=(handler)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  # @abstract
  # @param [String] request
  # @return [String, nil]
  def handle(request)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

# The default chaining behavior can be implemented inside a base handler class.
class AbstractHandler < Handler
  # @return [Handler]
  attr_writer :next_handler

  # @param [Handler] handler
  # @return [Handler]
  def next_handler(handler)
    @next_handler = handler
    # Returning a handler from here will let us link handlers in a convenient way like this:
    # monkey.next_handler(cat).next_handler(dog)
    handler
  end

  # @abstract
  # @param [String] request
  # @return [String, nil]
  def handle(request)
    return @next_handler.handle(request) if @next_handler

    nil
  end
end

# All Concrete Handlers either handle a request or pass it to the next handler in the chain.
class MonkeyHandler < AbstractHandler
  # @param [String] request
  # @return [String, nil]
  def handle(request)
    if request == 'Banana'
      "Monkey: I'll eat the #{request}"
    else
      super(request)
    end
  end
end

class CatHandler < AbstractHandler
  # @param [String] request
  # @return [String, nil]
  def handle(request)
    if request == 'Fish'
      "Cat: I'll eat the #{request}"
    else
      super(request)
    end
  end
end

class DogHandler < AbstractHandler
  # @param [String] request
  # @return [String, nil]
  def handle(request)
    if request == 'Dog Food'
      "Dog: I'll eat the #{request}"
    else
      super(request)
    end
  end
end

# The client code is usually suited to work with a single handler.
def client_code(handler)
  ['Fish', 'Banana', 'Coffee', 'Cake', 'Dog Food'].each do |food|
    puts "\n"
    puts "Client: Who wants a #{food}?"
    result = handler.handle(food)
    if result
      puts " #{result}"
    else
      puts " #{food} was left untouched."
    end
  end
end

monkey = MonkeyHandler.new
cat = CatHandler.new
dog = DogHandler.new

monkey.next_handler(cat).next_handler(dog)

# The client should be able to send a request to any handler, not just the first one in the chain.
puts 'Chain: Monkey > Cat > Dog'
client_code(monkey)

puts "\n\n"

puts 'Subchain: Cat > Dog'
client_code(cat)
