require 'os'
module API
  module Videos
    class GetSeg < Grape::API
      # include Defaults

      params do
        requires :seg_uid, type: String
        requires :id, type: Integer
      end

      get 'seg' do
        content_type "application/octet-stream"

        params[:seg_uid]

        File.open("tmp/vseg/#{params[:seg_uid]}/seg-#{params[:id]}.mkv").read
      rescue StandardError => e
        error! e.message
      end
    end
  end
end
