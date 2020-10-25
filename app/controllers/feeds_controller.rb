class FeedsController < ApplicationController
  def index
    @feeds = Feed.all
  end

  def new
    @feed = Feed.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @feed = Feed.new(feed_params)
    respond_to do |format|
      if @feed.save
        CreateContentsJob.perform_now(@feed)
        format.js { flash.now[:notice] = 'Le flux RSS a bien été ajouté' }
      else
        format.js
        @feed.errors.any?
        @feed.errors.each do |key, value|
        end
      end
    end
  end

  def update
    @content = Content.find params[:id]
    @content.update(readed: 1)
    respond_to do |format|
      format.js
    end
  end

  def feed_params
    params.require(:feed).permit(:title, :url)
  end
end
