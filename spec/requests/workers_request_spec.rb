require 'rails_helper'

RSpec.describe "Workers Controller", type: :request do
  context 'Logged as Normal User' do
    before do
      user_uber = create(:user_uber)
      login_as(user_uber)
    end

    it "Can't access the workers index" do
      expect { get workers_path }.to raise_error(Pundit::NotAuthorizedError)
    end
  end

  context 'Logged as User Admin' do
    before :all do
      @user = create(:user_admin)
      @worker = create(:worker)
    end

    before do
      login_as(@user)
    end

    let(:params_worker) { attributes_for(:worker) }
    let(:params_worker_update) { attributes_for(:worker_update) }

    it "Can access the worker index page" do
      get workers_path
      expect(response).to have_http_status(200)
    end

    context 'Action Destroy' do
      let(:destroy_action) { post destroy_worker_path(@worker) }
      it 'Delete 1 instance of worker when using action destroy' do
        expect { destroy_action }.to change(Worker.where(is_destroyed: true), :count).by(1)
      end

      it 'Redirect after destroy' do
        destroy_action
        expect(response).to have_http_status(302)
      end
    end

    context 'Action Create' do
      let(:create_action) { post workers_path, params: { worker: params_worker, format: 'js' } }

      it 'Add one instance of Worker when using create' do
        expect { create_action }.to change(Worker, :count).by(1)
      end
    end

    context 'Action Update' do
      let(:update_action) { patch worker_path(@worker), params: { worker: params_worker_update } }

      it 'Update the attributes of Worker' do
        update_action
        @worker.reload
        expect(@worker.first_name).to eq(params_worker_update[:first_name])
        expect(@worker.last_name).to eq(params_worker_update[:last_name])
      end
    end
  end
end
