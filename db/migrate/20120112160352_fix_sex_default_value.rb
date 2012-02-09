class FixSexDefaultValue < ActiveRecord::Migration
  def up
    change_column_default(:users, :sex, true)
  end

  def down

  end
end
