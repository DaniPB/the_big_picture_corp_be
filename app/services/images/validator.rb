module Images
  module Validator
    def check_file
      raise Errors::FILE_NOT_FOUND unless File.exist?(file_path)
      raise Errors::FILE_EMPTY     if File.zero?(file_path)

      { success: 'Valid File' }
    rescue StandardError => ex
      { error: "Error: #{ex.message}, File: #{file_path}" }
    end

    def check_url(url)
      tempfile = Down.download(url)
      content_type = tempfile.content_type
      mime_type = MIME::Types[content_type].first

      unless mime_type&.media_type == 'image'
        raise Errors::URL_INVALID_CONTENT_TYPE
      end

      { success: 'Valid URL', tempfile: tempfile }
    rescue StandardError => ex
      { error: "Error: #{ex.message}" }
    end
  end
end
