class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
    @wikis = Wiki.all
  end

  def new
    @wiki = Wiki.new
    @wikis = Wiki.all
  end

  def create
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]

    if @wiki.save
      flash[:notice] = "Wiki saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "Error saving wiki. Try again!"
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    @wikis = Wiki.all
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]

    if @wiki.save
      flash[:notice] = "Wiki updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "Error saving updates. Try again!"
      render :new
    end

  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "An error occurred while deleting this topic. Maybe God doesn't want it gone?"
      render :show
    end
  end
end
