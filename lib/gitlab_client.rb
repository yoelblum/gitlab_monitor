require 'benchmark'
require 'open-uri'
##
#This class monitors Gitlab services by calculating GET average response time

class GitlabClient
    GITLAB_URL = 'http://www.gitlab.com'
    #Constructo to creates a new GitlabClient
    # * *Args*   :
    #   -+interval+ -> Time to wait between requests
    #   -+times+    -> Number of requets to perform
    #   -+url_to_minotor+ -> Gitlab service url to monitor
    def initialize(interval: 10, times: 6, url_to_monitor: GITLAB_URL)
        @interval = interval
        @times = times
        @url_to_monitor = url_to_monitor
    end

    #Fires @times requests, waiting @interval between each request
    #prints each request response time
    # * *Returns* :
    #   - average response time
    def get_average_response
        last_tick = Time.now
        total_runs = 0
        total_response_time = 0
        response_times = []
        while (total_runs < @times) do
          sleep 0.1
          if Time.now - last_tick >= @interval || total_runs == 0
            last_tick += @interval
            total_runs = total_runs + 1
            curr_time = Benchmark.realtime {fetch_webpage }
            puts "Response #{total_runs}: #{curr_time}"
            response_times.push(curr_time)
          end
        end
        return response_times.sum / @times
    end

    private

    def fetch_webpage
        response = open(@url_to_monitor).read
    end
end