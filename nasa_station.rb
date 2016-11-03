# This class describe the NASA station
class Station
  attr_reader :data, :max_x, :max_y

  def initialize(input)
    lines = input.split("\n")
    @max_x = lines[0].split(' ')[0].to_i
    @max_y = lines[0].split(' ')[1].to_i
    @data = {
      first: { position: lines[1], instructions: lines[2] },
      second: { position: lines[3], instructions: lines[4] },
    }
  rescue Exception => e
    puts "Invalid input. #{e.message}"
  end

  # explore the plateau
  def explore
    result = []
    data.keys.each do |key|
      rover = Rover.new(data[key][:position], [max_x, max_y])
      result << rover.run(data[key][:instructions])
    end
    puts result.join("\n")
  end
end


# This class describe a Rover behavior
class Rover
  def initialize(position, max_xy)
    @max_xy = max_xy
    position = position.split(' ')
    @pos_x = position[0].to_i
    @pos_y = position[1].to_i
    @orientation = Orientation.new(position[2])
  end
  
  def position
    [pos_x, pos_y, orientation.value].join(' ')
  end  

  # run rover - execution the sequence of instructions
  def run(instructions)
    instructions.split('').each do |i|
      case i
      when 'L'
        orientation.left
      when 'R'
        orientation.right
      when 'M'
        move
      else
        puts "Invalid instruction: #{i}"
      end
    end
    position
  end

  private

  attr_reader :max_xy
  attr_accessor :pos_x, :pos_y, :orientation

  # move rover
  def move
    new_pos_x = pos_x
    new_pos_y = pos_y
    # calculate new position
    case orientation.value
    when 'N'
      new_pos_y += 1
    when 'E'
      new_pos_x += 1
    when 'S'
      new_pos_y -= 1
    when 'W'
      new_pos_x -= 1
    else
      puts "Rover has invalid orientation: #{orientation}"
    end
    # to keep rover inside the plateau
    # (because rover is very expensive and we don't want to break it down)
    if new_pos_x > max_xy[0]
      new_pos_x -= 1
    elsif new_pos_x < 0
      new_pos_x += 1
    end
    if new_pos_y > max_xy[1]
      new_pos_y -= 1
    elsif new_pos_y < 0
      new_pos_y += 1
    end
    self.pos_x = new_pos_x
    self.pos_y = new_pos_y
  end
end

# This class describe a Rover's orientation
class Orientation
  attr_accessor :value

  def initialize(value)
    @value = value
  end

  def left
    case value
    when 'N'
      self.value = 'W'
    when 'E'
      self.value = 'N'
    when 'S'
      self.value = 'E'
    when 'W'
      self.value = 'S'
    else
      puts "Orientation has invalid value: #{value}"
    end
  end

  def right
    case value
    when 'N'
      self.value = 'E'
    when 'E'
      self.value = 'S'
    when 'S'
      self.value = 'W'
    when 'W'
      self.value = 'N'
    else
      puts "Orientation has invalid value: #{value}"
    end
  end
end
