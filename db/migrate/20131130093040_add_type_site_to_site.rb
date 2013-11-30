class AddTypeSiteToSite < ActiveRecord::Migration
  def change
    add_column :sites, :type_site, :string
  end
end
