namespace :images do
  desc 'Downloads batch of images'
  task :download_batch, [:file_path] => :environment do |_, args|
    log = ActiveSupport::Logger.new('log/images_download_batch.log')
    start_time = Time.now

    log.info "Task started at #{start_time}"

    images_download = Images::Downloader.new(args[:file_path]).call

    if images_download[:error]
      log.error "👻 #{images_download[:error]}"
    else
      message = <<-HEREDOC
        ✅ IMAGES DOWNLOADED: #{images_download[:images_downloaded]}
        👻 ERRORS: #{images_download[:errors]}
      HEREDOC

      log.info message
    end

    end_time = Time.now
    duration = (end_time - start_time) / 1.minute

    log.info "Task finished at #{end_time} and lasted #{duration} minutes."
    log.close
  rescue => ex
    log.error ex.message
    log.close
  end
end
