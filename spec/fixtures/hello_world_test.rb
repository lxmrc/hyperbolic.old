require_relative "hello_world"

class HelloWorldTest < Minitest::Test
  def test_it_says_hello_world
    assert_equal "Hello, world!", HelloWorld.hello
  end
end
