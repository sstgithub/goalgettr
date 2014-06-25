class TasksController < ApplicationController

	# GET /tasks for current_user
	# GET new /task 
	def index
		if current_user
			@tasks = current_user.tasks.where(completed: false)
			@i1u0_tasks = @tasks.where(importance: 1, urgency: 0)
			@i1u1_tasks = @tasks.where(importance: 1, urgency: 1)
			@i0u0_tasks = @tasks.where(importance: 0, urgency: 0)
			@i0u1_tasks = @tasks.where(importance: 0, urgency: 1)
			@hash = Gmaps4rails.build_markers(@tasks) do |task, marker|
			  marker.lat task.latitude
			  marker.lng task.longitude
			  marker.infowindow "<a target='blank' href=#{task_path(task)}>#{task.task_name}: </a>"
			  marker.json({ title: task.task_name })
			end
		end
		@task = Task.new
		
	end

	def show
		@task = Task.find(params[:id])
		if @task.geocoded?
			@location = [@task.latitude, @task.longitude]
			@near_tasks = Task.near(@location, 8)
			@nearby_tasks = @near_tasks.where(completed: false)
			@hash = Gmaps4rails.build_markers(@nearby_tasks) do |task, marker|
			  marker.lat task.latitude
			  marker.lng task.longitude
			  marker.infowindow "<a target='blank' href=#{task_path(task)}>#{task.task_name}: </a>"
			  marker.json({ title: task.task_name })
			end
		end
		@i1u0_tasks = @nearby_tasks.where(importance: 1, urgency: 0)
		@i1u1_tasks = @nearby_tasks.where(importance: 1, urgency: 1)
		@i0u0_tasks = @nearby_tasks.where(importance: 0, urgency: 0)
		@i0u1_tasks = @nearby_tasks.where(importance: 0, urgency: 1)
	end

	def completed
		@tasks = current_user.tasks.where(completed: true)
		@i1u0_tasks = @tasks.where(importance: 1, urgency: 0)
		@i1u1_tasks = @tasks.where(importance: 1, urgency: 1)
		@i0u0_tasks = @tasks.where(importance: 0, urgency: 0)
		@i0u1_tasks = @tasks.where(importance: 0, urgency: 1)
		@task = Task.new
		@hash = Gmaps4rails.build_markers(@tasks) do |task, marker|
		  marker.lat task.latitude
		  marker.lng task.longitude
		  marker.infowindow "<a target='blank' href=#{task_path(task)}>#{task.task_name}: </a>"
		  marker.json({ title: task.task_name })
		end
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

		if current_user
			@task = current_user.tasks.build(new_task_params)
			if @task.save
				redirect_to tasks_path
			else
				redirect_to :back
			end
		else
			redirect_to new_user_session_path
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

	def change_completed
		@task = Task.find(params[:id])
		if @task.completed
			val = false
		else
			val = true
		end
		@task.update_attributes(:completed => val)
		redirect_to tasks_path
	end

	def free_time
		@tasks = current_user.tasks.where(completed: false)
		@i1u0_tasks = @tasks.where(importance: 1, urgency: 0)
		@i1u1_tasks = @tasks.where(importance: 1, urgency: 1)
		@i0u0_tasks = @tasks.where(importance: 0, urgency: 0)
		@i0u1_tasks = @tasks.where(importance: 0, urgency: 1)
		@task = Task.new
		@hash = Gmaps4rails.build_markers(@tasks) do |task, marker|
		  marker.lat task.latitude
		  marker.lng task.longitude
		  marker.infowindow "<a target='blank' href=#{task_path(task)}>#{task.task_name}: </a>"
		  marker.json({ title: task.task_name })
		end
	end

	private

	def task_params
		params.require(:task).permit(:task_name, :est_time, :description, :status, :created_at, :updated_at, :due_datetime, :importance, :urgency, :latitude, :longitude, :address)
	end
end
