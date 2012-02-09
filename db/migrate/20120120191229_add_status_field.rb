class AddStatusField < ActiveRecord::Migration
  def up
    add_column(:users, :status, :text)
  end

  def down
    remove_column(:users,:status)
  end
end
