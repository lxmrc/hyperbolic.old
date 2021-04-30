class IterationsController < ApplicationController
  before_action :set_exercise
  before_action :set_iteration, only: [:show, :edit, :update, :destroy]
  before_action :find_container, only: [:run_tests, :stop_container]

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
    Containers::Start.new(exercise: @exercise, token: params[:token]).call
    head :ok
  end

  def run_tests
    @output = Containers::Run.new(container: @container, exercise: @exercise, code: params[:code]).call
    respond_to do |format|
      format.js
    end
  end

  def stop_container
    Containers::Stop.new(container: @container).call
  end

  private

    def find_container
      @container = Docker::Container.get($redis.get(params[:token]))
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
