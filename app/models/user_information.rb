class UserInformation < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :hobby

  before_save :default_image_attach

  private

    def default_image_attach
      unless self.image.attached?
        self.image.attach(io: File.open("app/assets/images/defaultUserIcon.png"), filename: "defaultUserIcon.png", content_type: "image/png")
      end
    end
end
