class AddRegisterTokenToSubscribers < ActiveRecord::Migration[5.1]
  def change
    add_column :subscribers, :register_token, :string
  end
end
