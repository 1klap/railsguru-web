class CreateLessons < ActiveRecord::Migration[8.0]
  def change
    create_table :lessons do |t|
      t.string :title
      t.text :slug
      t.text :summary
      t.text :content_text
      t.text :content_html
      t.references :user, null: false, foreign_key: true
      t.boolean :published, default: false
      t.datetime :published_at

      t.timestamps
    end
    add_index :lessons, :slug
  end
end
