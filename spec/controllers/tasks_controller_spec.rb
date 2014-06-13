# require 'spec_helper'
require 'rails_helper'
# include ControllerHelpers

describe TasksController do

	describe "GET #index" do

		# before (:each) do
		# 	sign_in
		# end

		it 'assigns collection of tasks' do
			sign_in
			current_user = user
			f = FactoryGirl.create(:task)
			get :index
			assigns(:tasks).count.should eq(1)
		end

		it 'renders the index page' do
		end
	end

	describe "POST #create" do
		it 'creates a new task' do
		end

	end

end