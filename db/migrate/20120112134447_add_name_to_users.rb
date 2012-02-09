class AddNameToUsers < ActiveRecord::Migration
  def change
    change_table(:users) do |t|
      t.string :name
      t.string :surname
      t.string :nickname
      t.date  :birthday
      t.boolean :sex, :default => true
      t.string :country
      t.string :city
      t.string :phone
      t.string :skype
      t.string :university
      t.string :school
      t.text  :interests
      t.text :address
    end
  end
end
