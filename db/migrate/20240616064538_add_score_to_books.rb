class AddScoreToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :score, :int
  end
end
