class CreateAlerts < ActiveRecord::Migration[5.2]
  def change
    create_table :alerts do |t|
      t.string :market_id
      t.float :spread

      t.timestamps
    end
  end
end
