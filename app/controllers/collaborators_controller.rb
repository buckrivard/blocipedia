class CollaboratorsController < ApplicationController

  def create
    @wiki = Wiki.find(params[:wiki_id])
    user = User.find(params[:user_id])
    c = Collaborator.new(user: user, wiki: @wiki)
    if c.save
      redirect_to @wiki, notice: 'Collaborator added'
    end
  end

end
