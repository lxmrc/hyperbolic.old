require "rails_helper"
require_relative "../../app/services/containers/run"

RSpec.describe Containers::Run do
  before do
    @exercise = FactoryBot.create(:exercise)
    Containers::Start.new(exercise: @exercise, token: "12345").call
    @container = Docker::Container.get($redis.hget("12345", :container_id))
  end

  after :each do
    Docker::Container.all(all: true).each { |c| c.stop && c.delete }
    $redis.flushdb
  end

  subject(:service) { described_class.new(container: @container, exercise: @exercise, code: "1") }

  it "runs the tests" do
    expect(@container).to receive(:exec).with(["ruby", "/exercise/#{@exercise.test_file_name}", "--verbose"]).and_call_original

    service.call
  end
end
