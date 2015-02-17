class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      #has_many :list_items
      t.string :name
    end
  end
end
