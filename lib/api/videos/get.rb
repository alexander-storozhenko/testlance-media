# frozen_string_literal: true

require 'api/helpers/headers_helper'
require 'api/auth'

module API
  module Videos
    class Get < Grape::API
      include Auth

      helpers HeadersHelper

      format :binary
      # authenticate!

      EXT = '.mp4'

      params do
        requires :uid, type: String
      end

      get ':uid' do
        video = Video.find_by(uid: params[:uid])
        video_uid = video.uid

        content_type 'application/octet-stream'

        file = video.attachment.blob.open { |tempfile| File.open(tempfile.path, 'rb') }

        media_broadcast_headers(
          media: file,
          file_name: video_uid,
          ext: EXT,
          duration: 12.5
        )

        file.read
      rescue StandardError => e
        error! e.message
      end
    end
  end
end

