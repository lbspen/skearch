require 'spec_helper'

RSpec.describe SnapshotController, :type => :controller do
  before do
    stub(Crawler).new.stub!.crawl
  end

  describe "GET new" do
    before do
      get :new
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end

    it 'assigns a new snapshot to @snapshot' do
      expect(assigns(:snapshot)).not_to be_nil
    end
  end

  describe "GET create" do
    context 'with valid attributes' do
      it 'creates a new snapshot' do
        expect{
          get :create, snapshot: attributes_for(:snapshot)
        }.to change(Snapshot, :count).by(1)
      end

      it 'redirects to the new snapshot' do
        get :create, snapshot: attributes_for(:snapshot)
        expect(response).to redirect_to Snapshot.last
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new snapshot' do |variable|
        expect{
          get :create, snapshot: attributes_for(:invalid_snapshot)
        }.not_to change(Snapshot, :count)
      end

      it 're-renders the new template' do
        get :create, snapshot: attributes_for(:invalid_snapshot)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET delete" do
    it "returns http success" do
      get :delete
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

end
