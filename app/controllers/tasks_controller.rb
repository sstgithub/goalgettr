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
		@task = current_user.tasks.build(task_params)
		# if @task.save
		# 	redirect_to tasks_path
		# else
		# 	redirect_to :back
		# end

		respond_to do |format|
      if @task.save
        if request.xhr?
          return render :partial => 'task', :object => @task
        else
          flash[:notice] = 'Task was successfully created.'
          format.html { redirect_to(@task) }
          format.xml  { render :xml => @task, :status => :created, :location => @task }
        end
      else
        if request.xhr?
          return render :action => 'new', :layout => false, :status => :unprocessable_entity
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }          
        end        
      end
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
		params.require(:task).permit(:task_name, :description, :status, :created_at, :updated_at, :due_datetime, :importance.to_s, :urgency.to_s, :latitude, :longitude)
	end
end
