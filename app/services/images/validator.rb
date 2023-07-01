module Images
  module Validator
    def check_file
      raise "not found" unless File.exist?(file_path)
      raise "is empty" if File.zero?(file_path)

      { success: 'Valid File' }
    rescue StandardError => ex
      { error: "Error: File #{file_path}, #{ex.message}" }
    end

    def check_url(url)
      tempfile = Down.download(url)
      content_type = tempfile.content_type
      mime_type = MIME::Types[content_type].first

      unless mime_type&.media_type == 'image'
        raise "is not an image"
      end

      { success: 'Valid URL', tempfile: tempfile }
    rescue StandardError => ex
      { error: "Error: Url #{url}, #{ex.message}" }
    end
  end
end
