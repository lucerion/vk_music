require 'yaml/store'

module VKMusic
  class Database
    PATH = '../../../database.yml'.freeze

    def initialize
      @store = YAML::Store.new(File.expand_path(PATH, __FILE__))
    end

    def get(id)
      @store.transaction(true) { @store[id] }
    end

    def set(id, attributes)
      @store.transaction { @store[id] = attributes }
    end

    def exists?(id)
      !get(id).nil?
    end
  end
end
