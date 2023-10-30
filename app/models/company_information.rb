class CompanyInformation < ApplicationRecord
  belongs_to :user, dependent: :destroy
end
