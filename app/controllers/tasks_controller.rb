class TasksController < ApplicationController
  TASKS_LIST = [
    {id:1,title:"Cleaning",description:"incomplete"},
    {id:2,title:"Washing",description:"complete"},
    {id:3,title:"Cooking",description:"complete"}]
  def index
    @tasks = Task.all
  end

  def show
    id = params[:id]
      @task = Task.find(id)

  end

  def new
    @task = Task.new
  end

  def create

    task= Task.new
    task.assign_attributes(task_params)
    if task.save
      redirect_to tasks_path
    else
      render:new
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
  end

  def update
    @task = Task.find_by(id: params[:id])
      if !@task.nil?
      if @task.update(task_params)
           redirect_to task_path(@task.id)
        else
          render :edit
        end
      else
        redirect_to tasks_path

      end

  end

  def destroy
    id = params[:id]
      @task = Task.find(id)
      if@task
        @task.destroy
      end
      redirect_to tasks_path
  end

  def completed
  task = Task.find(params[:id])

  if task.completed
    task.completed = false
    task.completed = nil
  else
    task.completed = true
    task.completed = Date.today
  end

  if task.save
    redirect_to tasks_path
  end
end

  private

  def task_params
    return params.require(:task).permit(:title, :description, :completion_date)
  end
end
