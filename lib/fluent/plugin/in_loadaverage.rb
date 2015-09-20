module Fluent
  class LoadAverageInput < Input
    Plugin.register_input("loadaverage", self)

    config_param :tag, :string
    config_param :interval, :integer, :default => 60

    class TimerWatcher < Coolio::TimerWatcher
      def initialize(interval, repeat, &callback)
        @callback = callback
        super(interval, repeat)
      end

      def on_timer
        @callback.call
      end
    end

    def configure(conf)
      super
    end

    def start
      @loop = Coolio::Loop.new
      @timer = TimerWatcher.new(@interval, true, &method(:uptime))
      @loop.attach(@timer)
      @thread = Thread.new(&method(:run))
    end

    def shutdown
      @loop.watchers.each {|w| w.detach }
      @loop.stop
      @thread.join
    end

    def run
      @loop.run
    rescue
      log.error "unexpected error", :error => $!.to_s
      log.error_backtrace
    end

    def uptime
      past1_min, past5_min, past15_min =
        `uptime`.chomp.match(/load average(?::|s:) (\d+\.\d+)(?:,|) (\d+\.\d+)(?:,|) (\d+\.\d+)$/).to_a.values_at(1,2,3)
      router.emit(@tag, Engine.now, { past_1min: past1_min, past_5min: past5_min, past_15min: past15_min })
    end
  end
end
