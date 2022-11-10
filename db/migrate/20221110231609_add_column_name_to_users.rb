# frozen_string_literal: true

class AddColumnNameToUsers < ActiveRecord::Migration[5.2] # rubocop:todo Style/Documentation
  def change
    add_index :users, :email, unique: true
  end
end
