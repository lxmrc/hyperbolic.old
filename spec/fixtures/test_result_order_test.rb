require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/reporters/json_reporter'
Minitest::Reporters.use! Minitest::Reporters::JsonReporter.new

class HelloWorldTest < Minitest::Test
  def test_one
    assert_true
  end

  def test_two
    assert_true
  end

  def test_three
    assert_true
  end
end
