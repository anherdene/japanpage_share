class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :message
      t.references :sender
      t.references :recepient

      t.timestamps
    end
  end
end
