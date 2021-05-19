module Containers
  class Run
    def initialize(container:, exercise:, code:)
      @container = container
      @exercise = exercise
      @code = code
    end

    def call
      container.store_file("/exercise/#{exercise.exercise_file_name}", code)
      container.exec(["ruby", "/exercise/#{exercise.test_file_name}"])[0][0]
    rescue Docker::Error::ConflictError, Docker::Error::NotFoundError
      false
    end

    private

    attr_reader :container, :exercise, :code
  end
end
