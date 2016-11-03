require 'test/unit'
require_relative 'nasa_station'

class TestOrientation < Test::Unit::TestCase
  def test_left
    o = Orientation.new('S')
    o.left
    assert_equal('E', o.value)
    o.left
    assert_equal('N', o.value)
    o.left
    assert_equal('W', o.value)
    o.left
    assert_equal('S', o.value)
  end

  def test_right
    o = Orientation.new('S')
    o.right
    assert_equal('W', o.value)
    o.right
    assert_equal('N', o.value)
    o.right
    assert_equal('E', o.value)
    o.right
    assert_equal('S', o.value)
  end
end

class TestRover < Test::Unit::TestCase
  def test_position
    rover = Rover.new('1 1 E', [5,5])
    assert_equal('1 1 E', rover.position)
  end  
  
  def test_run
    rover = Rover.new('1 1 E', [5,5])
    assert_equal('2 2 N', rover.run('MLM'))
  end  
  
  def test_move
    rover = Rover.new('2 2 N', [5,5])
    rover.send(:move)
    assert_equal('2 3 N', rover.position)
  end  
  
  def test_rover_safety
    rover = Rover.new('2 2 S', [5,5])
    assert_equal('2 0 S', rover.run('MMMM'))
    assert_equal('5 0 E', rover.run('LMMMMMMMM'))
  end  
end 
