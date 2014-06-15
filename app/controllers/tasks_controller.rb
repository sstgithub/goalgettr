class TasksController < ApplicationController

	# GET /tasks for current_user
	# GET new /task 
	def index
		@tasks = current_user.tasks
		@task = Task.new
	end

	def show
		@task = Task.find(params[:id])
	end

	def new
		@task = Task.new
	end

	def edit
		@task = Task.find(params[:id])
	end

	def create
		@task = Task.new(task_params)
		if @task.save
			redirect_to tasks_path
		else
			redirect_to :back
		end
	end

	def update
		@task = Task.find(params[:id])
		if @task.update_attributes(task_params)
			redirect_to task_path(params[:id])
		else
			redirect_to :back
		end
	end

	def destroy
		@task = Task.find(params[:id])
		if @task.destroy
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
