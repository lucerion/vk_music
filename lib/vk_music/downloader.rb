module VKMusic
  class Downloader
    def initialize(config)
      @client = VKMusic::Client.new(config)
      @synchronizer = VKMusic::Synchronizer.new(config)
    end

    def run!
      @client.authenticate!
      @synchronizer.download(@client.audio.fetch('items'))
    end
  end
end
