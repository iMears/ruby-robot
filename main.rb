require 'arduino_firmata'

class Norton
  def initialize
    @norton = ArduinoFirmata.connect
    sleep 2
  end

  def forward(sec)
    @norton.servo_write 12, 1300
    @norton.servo_write 13, 1700
    sleep sec
    @norton.servo_write 12, 1500
    @norton.servo_write 13, 1500
  end

  def backward(sec)
    @norton.servo_write 12, 1700
    @norton.servo_write 13, 1300
    sleep sec
    @norton.servo_write 12, 1500
    @norton.servo_write 13, 1500
  end

  def right(angle)
    @norton.servo_write 12, 1700
    @norton.servo_write 13, 1700
    sleep 0.69 * angle / 90
    @norton.servo_write 12, 1500
    @norton.servo_write 13, 1500
  end

  def left(angle)
    @norton.servo_write 12, 1300
    @norton.servo_write 13, 1300
    sleep 0.69 * angle / 90
    @norton.servo_write 12, 1500
    @norton.servo_write 13, 1500
  end

  def beep(value)
    @norton.analog_write 3, true
    sleep 1
    @norton.analog_write 3, false
  end
end

norton = Norton.new

loop do
  print "command>"
  command = gets.chomp

  print "value>"
  value = gets.chomp.to_f

  case command
  when "forward"
    norton.forward(value)
  when "backward"
    norton.backward(value)
  when "right"
    norton.right(value)
  when "left"
    norton.left(value)
  when "beep"
    norton.beep(value)
  end
end