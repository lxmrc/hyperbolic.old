require "rails_helper"
require_relative "../../app/services/containers/keep_alive"

RSpec.describe Containers::KeepAlive do
  before do
    @exercise = FactoryBot.create(:exercise)
    Containers::Start.new(exercise: @exercise, token: "12345").call
  end

  after :each do
    Docker::Container.all(all: true).each { |c| c.stop && c.delete }
    $redis.flushdb
  end

  subject(:service) { described_class.new(exercise: @exercise, token: "12345") }

  it "updates last active time" do
    initial = $redis.hget("12345", :last_active).to_time
    sleep(1)
    service.call
    expect($redis.hget("12345", :last_active).to_time).to be > initial
  end
end
