# frozen_string_literal: true

class CreateFavorites < ActiveRecord::Migration[5.2] # rubocop:todo Style/Documentation
  def change
    create_table :favorites do |t|
      t.string :country
      t.string :recipe_link
      t.string :recipe_title
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
