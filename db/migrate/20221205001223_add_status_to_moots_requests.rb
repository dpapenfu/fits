class AddStatusToMootsRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :moots_requests, :status, :boolean
  end
end
