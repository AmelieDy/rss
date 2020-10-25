require 'rails_helper'

RSpec.describe "Feeds", type: :request do
  describe "get index" do
    it 'get index' do
      get feeds_path
      expect(assigns(:feeds)).to eq(Feed.all)
    end
  end

  describe "#create" do
    it "creates a successful feed" do
      @feed = Feed.create(title: "Message")
      @feed.should be_an_instance_of Feed
    end
  end

end
