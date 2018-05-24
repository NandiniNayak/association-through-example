class Teacher < ApplicationRecord
  has_many :subjects
  has_many :students, through: :subjects
end
