
class Gcal::Gateway::ConfigFile
  include Ccp::Commands::Core
  include Ccp::Utils::Colorize

  NotFound = Class.new(RuntimeError)
  Set = Struct.new(:key, :val)

  def execute
    return unless data?(:config_file)

    @sets = []

    config = data.path(:config_file)
    config.exist? or
      not_found("config file not found: path=#{config}")

    hash = load_yaml(config)
    parse(hash)
    report
  end

  def report
    max = @sets.map(&:key).map(&:size).max
    @sets.each do |set|
      value = set.val.inspect.truncate(65)
      color = "yellow"
      case set.key
      when "now"
        value = "#{value} # #{Time.at(set.val)}"
      when "send"
        color = "pink" if set.val == true
      end
      mes = "config: %-#{max}s = %s" % [set.key, value]
      colored_mes = __send__(color, mes) rescue mes
      logger.info colored_mes
    end
  end

  private
    def logger
      @logger ||= data[:logger]
    end

    def not_found(message)
      logger.fatal message
      raise NotFound, message
    end

    def load_yaml(config)
      YAML.load(config.read{}).must(Hash) {not_found("invalid yaml file: #{config}")}
    end

    def parse(hash)
      hash.each_pair do |key, val|
        set(key, val)
      end
    end

    def set(key, val)
      mes = "loading config: #{key}"
      key = key.to_sym

      method = "to_#{key}"
      val = __send__(method, val) if respond_to?(method, true)
      data[key] = val
      @sets << Set.new(key.to_s, val)
    rescue
      logger.info mes
      raise
    end
end
