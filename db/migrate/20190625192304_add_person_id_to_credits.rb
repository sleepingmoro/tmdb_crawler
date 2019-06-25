class AddPersonIdToCredits < ActiveRecord::Migration[5.2]
  def change
    add_column :credits, :person_id, :integer
  end
end
