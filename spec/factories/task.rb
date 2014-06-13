FactoryGirl.define do

	factory(:task) do
		user_id 19796968
		task_name "test task name here w00t"
		description "task description insert here"
		created_at Date.today
		updated_at Date.tomorrow
		status "Pending"
	end

end