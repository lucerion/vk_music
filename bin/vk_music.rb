#!/usr/bin/env ruby

require 'optparse'
require 'io/console'
require_relative '../lib/vk_music'

options = OptionParser.new
config = {}

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

options.parse!

raise ArgumentError, 'user is required' unless config[:user]
raise ArgumentError, 'application ID is required' unless config[:app_id]
if config[:directory] && !Dir.exist?(config[:directory])
  raise ArgumentError, "directory #{config[:directory]} does not exists"
end
raise ArgumentError, 'filename can not be blank' if config[:filename] && config[:filename].empty?

unless config[:password]
  print 'Password: '
  config[:password] = STDIN.noecho(&:gets).chomp
end
raise ArgumentError, 'password is required' if config[:password].empty?

VKMusic::Downloader.new(config).run
