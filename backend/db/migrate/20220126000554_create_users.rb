class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.integer :github_id
      t.string :name
      t.string :username
      t.string :avatar_url
      t.string :url

      t.timestamps
    end
  end
end
