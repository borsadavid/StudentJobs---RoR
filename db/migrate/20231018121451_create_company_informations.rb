class CreateCompanyInformations < ActiveRecord::Migration[7.0]
  def change
    create_table :company_informations do |t|
      t.string :name
      t.string :country
      t.string :address
      t.string :phone_number


      t.boolean :verified, default: false
      t.string :status
      t.references :user
      t.timestamps
    end
  end
end
