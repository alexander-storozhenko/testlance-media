class Video < ApplicationRecord
  include Rails.application.routes.url_helpers

  after_create :generate_uid

  has_one_attached :attachment

  def attachment_path
    ActiveStorage::Blob.service.path_for(attachment.key)
  end

  def generate_uid
    update!(uid: SecureRandom.uuid)
  end
end