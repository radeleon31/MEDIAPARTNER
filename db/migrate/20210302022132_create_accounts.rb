class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.integer :token
      t.integer :platform_name
      t.string :uid

      t.timestamps
    end
  end
end
