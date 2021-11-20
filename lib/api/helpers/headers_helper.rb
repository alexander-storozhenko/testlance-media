module API
  module HeadersHelper
    def media_broadcast_headers(media:, file_name:, ext:, duration:)
      file = media

      header 'Content-Length', (file.size - 2).to_s
      header 'Last-Modified', file.mtime
      header 'Cache-Control', 'public, must-revalidate, max-age=0'
      header 'Pragma', 'no-cache'
      header 'Accept-Ranges', 'bytes'
      header 'Content-Transfer-Encoding', 'binary'
      header 'Content-Duration', duration
      header 'X-Content-Duration', duration
      header 'Content-Disposition', "attachment; filename=#{file_name}#{ext}"
    end
  end
end
