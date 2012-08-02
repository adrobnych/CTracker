class AddVistedToCountries < ActiveRecord::Migration
  def self.up
    add_column :countries, :visited, :boolean, :default => false
  end

  def self.down
    remove_column :countries, :visited
  end
end
