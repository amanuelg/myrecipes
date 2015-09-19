class CreateChefs < ActiveRecord::Migration
  def change
    create_table :chefs do |t|
      t.string :chef_name
      t.string :email
      t.timestamp
    end
  end
end
