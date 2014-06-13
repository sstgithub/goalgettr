require 'spec_helper'
require 'rails_helper'
include DeviseSupportHelper

describe TasksController do

	describe "GET #index" do

		# before do
		# 	sign_in_as_a_valid_user
		# end

		it 'assigns collection of tasks' do
			u = FactoryGirl.create(:user)

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