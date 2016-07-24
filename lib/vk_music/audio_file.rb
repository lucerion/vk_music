require_relative './database'

module VKMusic
  class AudioFile
    DEFAULT_FILENAME_TEMPLATE = '%{artist} - %{title}.mp3'.freeze
    DEFAULT_DOWNLOAD_DIRECTORY_PATH = '../../../audio'.freeze

    attr_reader :id, :url

    def initialize(attributes, config)
      @config = config
      @database = VKMusic::Database.new

      @attributes = attributes
      @id = attributes.fetch('id')
      @url = attributes.fetch('url')
    end

    def self.default_download_directory_path
      File.expand_path(File.expand_path(DEFAULT_DOWNLOAD_DIRECTORY_PATH, __FILE__))
    end

    def filename
      filename_template % { artist: @attributes.fetch('artist'), title: @attributes.fetch('title') }
    end

    def path
      "#{download_directory}/#{filename}"
    end

    private

    def download_directory
      @config[:directory] || self.class.default_download_directory_path
    end

    def filename_template
      @config[:filename] || DEFAULT_FILENAME_TEMPLATE
    end
  end
end
