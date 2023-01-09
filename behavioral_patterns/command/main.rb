# frozen_string_literal: true

# The Command interface declares a method for executing a command.
class Command
  # @abstract
  def execute
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

# Some commands can implement simple operations on their own.
class SimpleCommand < Command
  # @param [String] payload
  def initialize(payload)
    @payload = payload
  end

  def execute
    puts "SimpleCommand: See, I can do simple things like printing (#{@payload})"
  end
end

# However, some commands can delegate more complex operations to other objects, called "receivers".
class ComplexCommand < Command
  # Complex commands can accept one or several receiver objects along with any context data via the constructor.
  def initialize(receiver, a, b)
    @receiver = receiver
    @a = a
    @b = b
  end

  # Commands can delegate to any methods of a receiver.
  def execute
    puts 'ComplexCommand: Complex stuff should be done by a receiver object'
    @receiver.do_something(@a)
    @receiver.do_something_else(@b)
  end
end

# The Receiver classes contain some important business logic.
class Receiver
  # @param [String] a
  def do_something(a)
    puts "\n"
    puts "Receiver: Working on (#{a}.)"
  end

  # @param [String] b
  def do_something_else(b)
    puts "\n"
    puts "Receiver: Also working on (#{b}.)"
  end
end

# The Invoker is associated with one or several commands. It sends a request to the command.
class Invoker
  # Initialize commands.

  # @param [Command] command
  def on_start=(command)
    @on_start = command
  end

  # @param [Command] command
  def on_finish=(command)
    @on_finish = command
  end

  # The Invoker does not depend on concrete command or receiver classes.
  # The Invoker passes a request to a receiver indirectly, by executing a command.
  def do_something_important
    puts 'Invoker: Does anybody want something done before I begin?'
    puts "\n"
    @on_start.execute if @on_start.is_a? Command
    puts "\n"
    puts 'Invoker: ...doing something really important...'
    puts "\n"
    puts 'Invoker: Does anybody want something done after I finish?'
    puts "\n"
    @on_finish.execute if @on_finish.is_a? Command
  end
end

# The client code can parameterize an invoker with any commands.
invoker = Invoker.new
invoker.on_start = SimpleCommand.new('Say Hello!')
receiver = Receiver.new
invoker.on_finish = ComplexCommand.new(receiver, 'Send email', 'Save report')

invoker.do_something_important
