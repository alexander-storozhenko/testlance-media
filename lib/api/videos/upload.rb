require 'rbconfig'

module API
  module Videos
    class Upload < Grape::API
      include Auth

      # authenticate!

      format :json

      params do
        requires :video, type: File
      end

      post 'upload' do
        content_type 'multipart/form-data'

        video_file = params[:video]
        video = Video.create!(user_id: @user_id)

        attachment = {
          filename: video_file[:filename],
          type: video_file[:type],
          headers: video_file[:head],
          tempfile: video_file[:tempfile]
        }

        video.attachment = ActionDispatch::Http::UploadedFile.new(attachment)

        video.save!
        ''
      rescue StandardError => e
        error! e.message
      end
    end
  end
end
