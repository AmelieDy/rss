class FeedsController < ApplicationController
  def index


    @feeds = Feed.all


  end

  def create
    @feed = Feed.new(feed_params)
    respond_to do |format|
      if @feed.save
        puts @feed
        CreateContentsJob.perform_now(@feed)
        format.js
      end
    end
  end

  def new
    @feed = Feed.new
    respond_to do |format|
      format.js
    end
  end

  def feed_params
    params.require(:feed).permit(:title, :url)
  end
end
