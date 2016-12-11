require 'optparse'
require 'io/console'
require_relative './options_validator'

module VKMusic
  class CLI
    attr_reader :args

    def initialize(args = ARGV)
      @args = args
      @config = {}
    end

    def run!
      options.parse!(args)
      ask_password
      validator.validate!
      downloader.run!
    end

    private

    attr_reader :config

    def options
      options = OptionParser.new

      options.banner = 'Usage: vk_music [OPTION]'

      options.on('-u', '--user EMAIL', 'user email. Required') do |option|
        config[:user] = option
      end

      options.on('-p', '--password PASSWORD', 'user password') do |option|
        config[:password] = option
      end

      options.on('-a', '--app-id NUMBER', 'application ID. Required') do |option|
        config[:app_id] = option
      end

      options.on('-d', '--directory PATH', 'download directory. Default: /path/to/vk_music/audio') do |option|
        config[:directory] = option
      end

      options.on('--count NUMBER', Integer, 'amount of audio files') do |option|
        config[:count] = option
      end

      options.on('--offset NUMBER', Integer, 'skip N audio files') do |option|
        config[:offset] = option
      end

      options.on('--filename TEMPLATE', 'file name template. Default: %{artist} - %{title}.mp3') do |option|
        config[:filename] = option
      end

      options.on_tail('--version', 'display version') do
        puts VKMusic::VERSION
        exit
      end

      options.on_tail('--help', 'display a usage message') do
        puts options
        exit
      end

      options
    end

    def ask_password
      return if config[:password]
      print 'Password: '
      config[:password] = STDIN.noecho(&:gets).chomp
    end

    def validator
      VKMusic::OptionsValidator.new(config)
    end

    def downloader
      VKMusic::Downloader.new(config)
    end
  end
end
