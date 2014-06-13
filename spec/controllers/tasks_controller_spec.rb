# require 'spec_helper'
require 'rails_helper'
# include ControllerHelpers

describe TasksController do

	describe "GET #index" do

		# before (:each) do
		# 	sign_in
		# end

		it 'assigns collection of tasks' do
			
			# current_user = user
			# current_user = :current_user
			u = FactoryGirl.create(:user)
			sign_in(u)
			f = FactoryGirl.create(:task, :user_id => u.id)
			get :index
			assigns(:tasks).count.should eq(1)
		end

		it 'renders the index page' do
			current_user = FactoryGirl.create(:user)
			sign_in(current_user)
			get :index
			response.should be_success
		end
	end

	describe "POST #create" do
		it 'creates a new task' do
			current_user = FactoryGirl.create(:user)
			sign_in(current_user)
			expect{
				post :create, task: FactoryGirl.attributes_for(:task)}.to change(Task, :count).by(1)
		end

	end

end