class ConfirmationOfFriendshipAdded < ActiveRecord::Migration
  def change
    change_table(:friendships) do |t|
      t.column :is_confirmed, :boolean, :null => true
    end
  end
end
