class IterationsController < ApplicationController
  before_action :set_exercise
  before_action :set_iteration, only: [:show, :edit, :update, :destroy]
  before_action :find_container, only: [:run_tests, :stop_container]

  def run_tests
    container_id = $redis.get(params[:token])
    container = Docker::Container.get(container_id)
    @output = container.exec(['ruby', @exercise.test_file_name])
  end

  def index
    @iterations = @exercise.iterations.all
  end

  def show
  end

  def new
    @iteration = @exercise.iterations.build
    @token = SecureRandom.hex(5)
  end

  def edit
  end

  def create
    @iteration = @exercise.iterations.build(iteration_params[:file])
    @iteration.number = @exercise.iterations_count + 1

    if @iteration.save
      @iteration.file.attach(io: StringIO.new(params[:iteration][:code]), filename: "#{@exercise.name}.rb")
      redirect_to [@exercise, @iteration], notice: 'Iteration was successfully created.'
    else
      render :new
    end
  end

  def update
    if @iteration.update(iteration_params)
      redirect_to @iteration, notice: 'Iteration was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @iteration.destroy
    redirect_to exercise_iterations_url, notice: 'Iteration was successfully destroyed.'
  end

  def start_container
    container = Docker::Container.create('Image' => 'ghcr.io/lxmrc/minitest:latest', 'Tty' => true)
    container.store_file("/exercise/" + @exercise.test_file_name, @exercise.tests)
    container.start
    $redis.set(@token, container.id)
  end

  def run_tests
    @container.store_file("/exercise/#{@exercise.exercise_file_name}", params[:code])
    @output = @container.exec(['ruby', @exercise.test_file_name])[0][0]
    respond_to do |format|
      #msg = { output: output }
      #format.json  { render :json => msg } 
      format.js
    end
  end

  def stop_container
    @container.stop
  end

  private

    def update_container
      container.store_file("/exercise/#{@exercise.exercise_file_name}", params[:iteration][:code])
    end

    def find_container
      @container = Docker::Container.get($redis.get(@token))
    end

    def set_exercise
      @exercise = Exercise.find(params[:exercise_id])
    end

    def set_iteration
      @iteration = @exercise.iterations.find(params[:id])
    end

    def iteration_params
      params.require(:iteration).permit(:file, :token, :code)
    end
end
