require 'rbconfig'

module API
  module Videos
    class Upload < Grape::API
      # include Defaults

      format :json

      params do
        requires :video, type: File
      end

      post 'upload' do
        content_type 'multipart/form-data'

        video = params[:video]
        video_path = video[:tempfile].path.strip

        VideoUploadJob.perform_now(1, video_path)

        ''
      rescue StandardError => e
        error! e.message
      end
    end
  end
end
