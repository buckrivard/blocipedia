class WikisController < ApplicationController
  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
    @wikis = Wiki.all
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    @wikis = Wiki.all
  end

  def create
    @wiki = Wiki.new
    @wiki.update(post_params)
    @wiki.user_id = current_user.id
    @wiki.private ||= false

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
    @wiki.update(post_params)

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

  private

  def post_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
