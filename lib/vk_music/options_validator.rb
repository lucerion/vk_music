module VKMusic
  class OptionsValidator
    attr_reader :config

    ERROR_MESSAGES = {
      user: 'user is required',
      app_id: 'application ID is required',
      directory: 'directory %{path} does not exists',
      filename: 'filename can not be blank',
      password: 'password is required'
    }.freeze

    def initialize(config)
      @config = config
    end

    def validate!
      validate_user!
      validate_app_id!
      validate_directory!
      validate_filename!
      validate_password!
    end

    private

    def validate_user!
      raise ArgumentError, ERROR_MESSAGES[:user] unless config[:user]
    end

    def validate_app_id!
      raise ArgumentError, ERROR_MESSAGES[:app_id] unless config[:app_id]
    end

    def validate_directory!
      directory = config[:directory]
      if directory && !Dir.exist?(directory)
        raise ArgumentError, ERROR_MESSAGES[:directory] % { path: directory }
      end
    end

    def validate_filename!
      raise ArgumentError, ERROR_MESSAGES[:filename] if config[:filename] && config[:filename].empty?
    end

    def validate_password!
      raise ArgumentError, ERROR_MESSAGES[:password] if config[:password].empty?
    end
  end
end
