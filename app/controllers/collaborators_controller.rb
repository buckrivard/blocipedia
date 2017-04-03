class CollaboratorsController < ApplicationController

	def create
		@wiki = Wiki.find(params[:wiki_id])
		user = User.find(params[:user_id])
		c = Collaborator.new(user: user, wiki: @wiki)

		if c.save
			flash[:notice] =  "Collaborator #{user.email} added to #{@wiki.title}"
		else
			flash[:notice] = 'Error adding collaborator. Please try again.'
		end
		redirect_to @wiki
	end

	def destroy
		@wiki = Wiki.find(params[:wiki_id])
		user = User.find(params[:user_id])
		c = Collaborator.find_by(user_id: user.id)

		if c.destroy
			flash[:notice] = "#{user.email} successfully removed as a collaborator."
		else
			flash[:alert] = "Failed to remove collaborator. Please try again."
		end
		redirect_to @wiki
	end
end
