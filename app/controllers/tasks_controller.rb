class TasksController < ApplicationController

	# GET /tasks for current_user
	# GET new /task 
	def index
		@tasks = current_user.tasks
		@task = Task.new
	end

	def new
		@task = Task.new
	end

	def create
		@task = Task.new(task_params)
		if @task.save
			redirect_to tasks_path
		else
			redirect_to :back
		end
	end

	private

	def task_params
		params.require(:task).permit!
	end
end
