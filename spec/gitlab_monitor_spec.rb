RSpec.describe GitlabMonitor do
  it "has a version number" do
    expect(GitlabMonitor::VERSION).not_to be nil
  end

  describe GitlabClient do 

    describe "constructor params" do 
      context ""
    end
    context "calculate average response time" do 
      it "returns average response time" do 
        gitlab_client = GitlabClient.new(interval: 2, times: 2)

        allow(gitlab_client).to receive(:fetch_webpage) {
          sleep(0.5)
        }
        resp = gitlab_client.get_average_response
        expect(resp).to be_within(0.1).of(0.5)
      end
    end
  end

end
