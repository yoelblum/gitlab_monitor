require "thor"
require "gitlab_monitor"

module GitlabMonitor
    class CLI < Thor

        desc "measure", "Measures Gitlab Services average response"
        method_option :threshold => 3.0
        def measure 
            average_response = GitlabClient.new.get_average_response
            puts "Average response: #{average_response}"
        end
    end
end