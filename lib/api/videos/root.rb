require_relative 'upload'
require_relative 'get_seg'

module API
  module Videos
    class Root < Grape::API
      namespace 'videos' do
        mount GetSeg
        mount Upload
      end
    end
  end
end
