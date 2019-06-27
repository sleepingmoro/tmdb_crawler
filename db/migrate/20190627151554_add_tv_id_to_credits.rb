class AddTvIdToCredits < ActiveRecord::Migration[5.2]
  def change
    add_column :credits, :tv_id, :integer
  end
end
