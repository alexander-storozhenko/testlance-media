require 'api/videos/root'

module API
  class API < Grape::API
    # helpers ApiHelper

    namespace 'api' do
      namespace 'v1' do
        mount Videos::Root
      end
    end
  end
end
