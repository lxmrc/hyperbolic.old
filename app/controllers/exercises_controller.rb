class ExercisesController < ApplicationController
  before_action :set_exercise, only: [:show, :edit, :update, :destroy, :setup, :attempt]

  def index
    @exercises = Exercise.all
  end

  def show
  end

  def new
    @exercise = Exercise.new
  end

  def edit
    @tests = @exercise.tests
  end

  def create
    @exercise = Exercise.new(exercise_params)

    if @exercise.save
      @exercise.test_file.attach(io: StringIO.new(params[:exercise][:tests]), filename: "#{@exercise.name}_test.rb")
      redirect_to @exercise, notice: 'Exercise was successfully created.'
    else
      render :new
    end
  end

  def update
    if @exercise.update(exercise_params)
      @exercise.test_file.attach(io: StringIO.new(params[:exercise][:tests]), filename: "#{@exercise.name}_test.rb")
      redirect_to @exercise, notice: 'Exercise was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @exercise.destroy
    redirect_to exercises_url, notice: 'Exercise was successfully destroyed.'
  end

  def setup
    container = Docker::Container.create('Image' => 'ghcr.io/lxmrc/minitest:latest', 'Tty' => true)
    container.store_file("/exercise/" + @exercise.test_file_name, @exercise.tests)
    container.start
  end

  def attempt
  end

  private
    def set_exercise
      @exercise = Exercise.find(params[:id])
    end

    def exercise_params
      params.require(:exercise).permit(:name, :description, :test_file)
    end
end
