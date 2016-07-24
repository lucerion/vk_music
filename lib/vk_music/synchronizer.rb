require 'open-uri'
require_relative './audio_file'

module VKMusic
  class Synchronizer
    def initialize(config)
      @config = config
      @database = VKMusic::Database.new
    end

    def download(audio)
      create_default_download_directory unless @config[:directory]
      audio.each do |attributes|
        audio_file = VKMusic::AudioFile.new(attributes, @config)
        save(audio_file) unless downloaded?(audio_file)
      end
    end

    private

    def create_default_download_directory
      FileUtils.mkdir_p(VKMusic::AudioFile.default_download_directory_path)
    end

    def downloaded?(audio_file)
      @database.exists?(audio_file.id) && File.exist?(@database.get(audio_file.id).fetch(:path))
    end

    def save(audio_file)
      puts audio_file.filename
      File.open(audio_file.path, 'wb') { |file| file.write(open(audio_file.url, 'rb').read) }
      @database.set(audio_file.id, path: audio_file.path)
    rescue OpenURI::HTTPError => error
      handle_error(error, audio_file)
    end

    def handle_error(error, audio_file)
      case error.io.status.first
      when '404', '504'
        puts "\tERROR: #{error.io.status.join(' ')}"
        puts "\tURL: #{audio_file.url}"
      else
        raise error
      end
    end
  end
end
