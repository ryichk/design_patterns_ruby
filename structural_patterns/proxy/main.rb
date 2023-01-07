# frozen_string_literal: true

# The Subject interface declares common operations for both RealSubject and the Proxy.
class Subject
  # @abstract
  def request
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

# The RealSubject contains some core business logic.
class RealSubject < Subject
  def request
    puts 'RealSubject: Handling request.'
  end
end

# The Proxy has an interface identical to the RealSubject.
class Proxy < Subject
  # @param [RealSubject] real_subject
  def initialize(real_subject)
    @real_subject = real_subject
  end

  # The most common application of the Proxy pattern are lazy loading, caching, controlling the access, logging, etc.
  def request
    return unless check_access

    @real_subject.request
    log_access
  end

  # @return [Boolean]
  def check_access
    puts 'Proxy: Checking access prior to firing a real request.'
    true
  end

  def log_access
    puts 'Proxy: Logging the time of request.'
  end
end

# The client code is supposed to work with all objects (both subjects and proxies) via the Subject interface in order to support both real subjects and proxies.
def client_code(subject)
  # ...

  subject.request

  # ...
end

puts 'Client: Executing the client code with a real subject:'
real_subject = RealSubject.new
client_code(real_subject)

puts "\n"

puts 'Client: Executing the same client code with a proxy:'
proxy = Proxy.new(real_subject)
client_code(proxy)
