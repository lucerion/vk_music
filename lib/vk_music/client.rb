require 'vkontakte'

module VKMusic
  class Client
    def initialize(config)
      @config = config
      @client = Vkontakte::Client.new(config[:app_id])
    end

    def authenticate!
      @client.login!(@config[:user], @config[:password], permissions: :audio)
    end

    def audio
      @client.api.audio_get(owner_id: @client.user_id, count: @config[:count], offset: @config[:offset])
    end
  end
end
