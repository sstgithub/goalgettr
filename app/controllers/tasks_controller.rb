class TasksController < ApplicationController

	# GET /tasks for current_user
	# GET new /task 
	def index
		@tasks = current_user.tasks
		@i1u0_tasks = @tasks.where(importance: 1, urgency: 0)
		@i1u1_tasks = @tasks.where(importance: 1, urgency: 1)
		@i0u0_tasks = @tasks.where(importance: 0, urgency: 0)
		@i0u1_tasks = @tasks.where(importance: 0, urgency: 1)
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
		new_task_params = task_params
		if new_task_params[:due_datetime] != ""
			new_task_params[:due_datetime] = DateTime.strptime(new_task_params[:due_datetime], '%m/%d/%Y %I:%M %p')
		end
		new_task_params[:importance] = task_params[:importance]
		new_task_params[:urgency] = task_params[:urgency]

		@task = current_user.tasks.build(new_task_params)

		if @task.save
			redirect_to task_path(@task.id)
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
		params.require(:task).permit(:task_name, :description, :status, :created_at, :updated_at, :due_datetime, :importance, :urgency, :latitude, :longitude, :address)
	end
end
