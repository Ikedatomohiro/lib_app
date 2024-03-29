# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string  :uid,                null: true
      t.string  :provider,           null: true
      t.string  :name,               null: true
      t.string  :nickname,           null: true
      t.string  :location,           null: true
      t.string  :image,              null: true
      t.string  :email,              null: true, default: ''
      t.string  :encrypted_password, null: true, default: ''
      t.string  :self_introduction,  null: true
      t.string  :oauth_token,        null: true
      t.string  :oauth_token_secret, null: true
      t.string  :twitter_link,       null: true
      t.boolean :admin_flg,          null: false, default: false
      t.integer :shelf_type,         null: false, default: '1'
      t.integer :user_type,          null: false, default: '1'
      t.boolean :del_flg,            null: false, default: false
      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, [:provider, :uid], unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
