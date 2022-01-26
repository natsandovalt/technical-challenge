class CreateRepositories < ActiveRecord::Migration[6.1]
  def change
    create_table :repositories do |t|
      t.integer :github_id
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :full_name
      t.boolean :private, default: false
      t.string :html_url
      t.text :description
      t.boolean :fork, default: false
      t.string :url

      t.timestamps
    end
  end
end
