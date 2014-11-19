class Comment < ActiveRecord::Base
  belongs_to :image

  # after_save do
  #   document.update_attribute(:admin_notification, true)
  # end
end
