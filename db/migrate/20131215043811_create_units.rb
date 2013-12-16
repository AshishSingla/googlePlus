class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :circle_name
      t.string :circle_id
      t.string :user_id

      t.timestamps
    end
  end
end
