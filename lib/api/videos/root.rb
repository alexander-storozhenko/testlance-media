require_relative 'get'
require_relative 'upload'

module API
  module Videos
    class Root < Grape::API
      namespace 'videos' do
        mount Get
        mount Upload
      end
    end
  end
end
