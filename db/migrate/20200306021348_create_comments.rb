class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :author_name
      t.text :body
      t.references :article, index: true, foreign_keys: true

      t.timestamps null: false
    end
  end
end
