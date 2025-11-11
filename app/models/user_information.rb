class UserInformation < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :hobby

  enum :gender, { "男性": 0, "女性": 1 }
  
  before_save :attach_default_image

  private

    def attach_default_image
      unless self.image.attached?
        self.image.attach(io: File.open("app/assets/images/defaultUserIcon.png"), filename: "defaultUserIcon.png", content_type: "image/png")
      end
    end
end
