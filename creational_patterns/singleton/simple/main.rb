# frozen_string_literal: true

# The Singleton class defines the `instance` method that lets clients access the unique singleton instance.
class Singleton
  @instance = new

  private_class_method :new

  # The static method that controls the access to the singleton instance.
  def self.instance
    @instance
  end

  def some_business_logic
    # ...
  end
end

# The client code.
s1 = Singleton.instance
s2 = Singleton.instance

if s1.equal?(s2)
  puts 'Singleton works, both variables contain the same instance.'
else
  puts 'Singleton failed, variables contain different instances.'
end
