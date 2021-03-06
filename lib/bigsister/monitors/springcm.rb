require "bigsister/monitor"
require "bigsister/file_info"
require "bigsister/directory_info"
require "springcm-sdk"

module BigSister
  class SpringcmMonitor < BigSister::Monitor
    def initialize(config, i)
      @client_id = config.fetch("client_id", nil)
      @client_secret = config.fetch("client_secret", nil)
      @data_center = config.fetch("data_center", nil)
      @path = config.fetch("path", nil)
      validate_config!
      @client = Springcm::Client.new(@data_center, @client_id, @client_secret)
      @client.connect!
      @folder = @client.folder(path: @path)
      super(config, i)
    end

    def files
      docs = []
      list = @folder.documents(offset: 0, limit: 20)
      while !list.nil?
        docs = docs + list.items
        list = list.next
      end
      res = docs.map { |document|
        FileInfo.new(
          name: document.name,
          file_size: document.native_file_size
        )
      }
      res
    end

    def directories
      dirs = []
      list = @folder.folders(offset: 0, limit: 20)
      while !list.nil?
        dirs = dirs + list.items
        list = list.next
      end
      res = dirs.map { |dir|
        DirectoryInfo.new(
          name: dir.name,
          file_count: dir.documents.total,
          directory_count: dir.folders.total
        )
      }
      res
    end

    private

    def validate_config!
      if @client_id.nil?
        raise BigSister::InvalidConfiguration.new("SpringCM client_id required.")
      end
      if @client_secret.nil?
        raise BigSister::InvalidConfiguration.new("SpringCM client_secret is required.")
      end
      if @client_secret.nil?
        raise BigSister::InvalidConfiguration.new("SpringCM data_center is required.")
      end
      if @path.nil?
        raise BigSister::InvalidConfiguration.new("SpringCM path is required.")
      end
    end
  end
end
