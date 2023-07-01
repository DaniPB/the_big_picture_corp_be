module Images
  class Downloader
    include Validator

    attr_reader :file_path

    def initialize(file_path)
      @file_path = file_path
    end

    def call
      file_validation = check_file(file_path)

      if file_validation[:success].present?
        urls = extract_urls_from_file

        process_files(urls)
      else
        file_validation
      end
    end

    private

    def process_files(urls)
      urls.each_with_object(base_response) do |url, response|
        validation_response = check_url(url)

        if validation_response[:success]
          tempfile = validation_response[:tempfile]

          save_in_hard_drive(tempfile)

          response[:images_downloaded] += 1
        else
          response[:errors] << validation_response.merge(url: url)
        end
      end
    end

    def save_in_hard_drive(tempfile)
      FileUtils.mv(tempfile.path, "./#{tempfile.original_filename}")
    end

    def extract_urls_from_file
      File.open(file_path, 'r') do |file|
        file.read.split(/\s+/)
      end
    end

    def base_response
      {
        images_downloaded: 0,
        errors: []
      }
    end
  end
end
