class Application < ApplicationRecord
  belongs_to :cv, dependent: :destroy
  belongs_to :job, dependent: :destroy
  attribute :viewed, :boolean, default: false
end
