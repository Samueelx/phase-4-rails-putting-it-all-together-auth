class AddUserIdToRecipe < ActiveRecord::Migration[7.0]
  def change
    add_reference :recipes, :user, null: false, foreign_key: true
  end
end
