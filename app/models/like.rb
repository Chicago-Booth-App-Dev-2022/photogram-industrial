class Like < ApplicationRecord
  belongs_to :photo
  belongs_to :fan, class_name: "User"
end
