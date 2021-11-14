require 'os'

class VideoUploadJob < ApplicationJob
  queue_as :uploading

  SEG_SIZE = '5M'.freeze
  SEG_PATH = Rails.root.join('tmp/vseg')

  def perform(user_id, video_path)
    video = Video.new(user_id: user_id)
    uid = SecureRandom.hex

    if OS.mac?
      `mkvmerge --split #{SEG_SIZE} -o #{SEG_PATH}/#{uid}/seg.mkv #{video_path}`
    end

    `rm -rf #{video_path}`

    video.uid = uid
    video.save!
  end
end
