class IterationsController < ApplicationController
  before_action :set_exercise
  before_action :set_iteration, only: [:show, :edit, :update, :destroy]

  def index
    @iterations = @exercise.iterations.all
  end

  def show
  end

  def new
    @iteration = @exercise.iterations.build
    @token = SecureRandom.hex(5)
    start_container
  end

  def edit
  end

  def create
    @iteration = @exercise.iterations.build(iteration_params[:file])
    @iteration.number = @exercise.iterations_count + 1

    case params[:commit]
    when "Update"
      update_container
    else
      if @iteration.save
        @iteration.file.attach(io: StringIO.new(params[:iteration][:code]), filename: "#{@exercise.name}.rb")
        redirect_to [@exercise, @iteration], notice: 'Iteration was successfully created.'
      else
        render :new
      end
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

  private
    def start_container
      container = Docker::Container.create('Image' => 'ghcr.io/lxmrc/minitest:latest', 'Tty' => true)
      container.store_file("/exercise/" + @exercise.test_file_name, @exercise.tests)
      container.start
      $redis.set(@token, container.id)
    end

    def update_container
      container_id = $redis.get(params[:iteration][:token])
      container = Docker::Container.get(container_id)
      container.store_file("/exercise/#{@exercise.exercise_file_name}", params[:iteration][:code])
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
