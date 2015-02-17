class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :due
      t.string :completed
      t.string :list_id
      #belongs_to :list
    end
  end
end
