require "rails_helper"
require_relative "../../app/services/containers/start"

RSpec.describe Containers::Start do
  before do
    @exercise = FactoryBot.create(:exercise)
  end

  after :each do
    Docker::Container.all(all: true).each { |c| c.stop && c.delete }
    $redis.flushdb
  end

  subject(:service) { described_class.new(exercise: @exercise, token: "12345") }

  it "returns true if it started a container" do
    expect(service.call).to eq(true)
  end

  it "actually creates a container" do
    service.call
    expect(Docker::Container.all.size).to eq(1)
  end

  it "stores the token-ID pair in Redis" do
    service.call
    expect($redis.hget("12345", :container_id)).to_not be_nil
  end

  it "stores the test file inside the container" do
    service.call
    container = Docker::Container.get($redis.hget("12345", :container_id))
    test_file = <<~TEST
      require 'minitest/autorun'
      require 'minitest/reporters'
      require 'minitest/reporters/json_reporter'
      Minitest::Reporters.use! Minitest::Reporters::JsonReporter.new

      require_relative "hello_world"

      class HelloWorldTest < Minitest::Test
        def test_it_says_hello_world
          assert_equal "Hello, world!", HelloWorld.hello
        end
      end
    TEST
    expect(container.read_file("/exercise/hello_world_test.rb")).to eq(test_file)
  end

  it "starts the container" do
    service.call
    container = Docker::Container.get($redis.hget("12345", :container_id))
    expect(container.json["State"]["Running"]).to eq(true)
  end
end
