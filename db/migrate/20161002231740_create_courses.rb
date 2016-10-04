class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.text :description
      t.string :university
      t.date :begin_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
