class RemoveCollaboratorsFromWikis < ActiveRecord::Migration
  def change
    remove_column :wikis, :collaborators, :string
  end
end
