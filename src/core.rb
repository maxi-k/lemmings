class Greeter
  def initialize(msg)
    @message = msg
  end

  def get_message(subject)
    @message % subject
  end
end

hello = Greeter.new("Hello, %s!")
puts hello.get_message "World"
puts hello.get_message "Everyone"
puts
bye = Greeter.new "Until next time, %s!"
puts bye.get_message "World"
puts bye.get_message "Everyone"
