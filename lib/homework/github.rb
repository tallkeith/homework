module Homework
  class Github
    include HTTParty
    base_uri "https://api.github.com"

    def initialize
      @auth_token = "a8ba164f9526540607f9a91b0625120ff5352f3e"
      @headers = {
        "Authorization" => "token #{@auth_token}",
        "User-Agent"    => "HTTParty"
      }
    end

    def get_user(username)
      Github.get("/users/#{username}", headers: @headers)
    end

    def list_members_by_team_name(org, team_name)
      teams = list_teams(org)
      team = teams.find { |team| team["name"] == team_name }
      list_team_members(team["id"])
    end

    def list_teams(organization)
      Github.get("/orgs/#{organization}/teams", headers: @headers)
    end

    def list_team_members(team_id)
      Github.get("/teams/#{team_id}/members", headers: @headers)
    end

    def list_issues(owner, repo)
      Github.get("/repos/#{owner}/#{repo}/issues")
    end

    def close_issue(org, issue_num)
      Github.patch("/repos/#{org}/issues/#{issue_num.to_i}", headers: @headers, body: {"state" => "closed"}.to_json)
    end

    def comment_on_issue(org, issue_num, comment)
      Github.post("/repos/#{org}/issues/#{issue_num}", headers: @headers, body: {"body" => "#{comment}"}.to_json)
  end
end

github = Homework::Github.new

binding.pry
