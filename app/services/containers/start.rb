module Containers
  class Start
    def initialize(exercise:, token:)
      @exercise = exercise
      @token = token
    end

    def call
      container = Docker::Container.create('Image' => 'ghcr.io/lxmrc/minitest:latest', 'Tty' => true)
      container.store_file("/exercise/" + exercise.test_file_name, exercise.tests)
      container.start
      $redis.set(token, container.id)
    end

    private

    attr_reader :exercise, :token
  end
end