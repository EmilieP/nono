# Description:
#   Integrate with GitHub merge API
#
# Dependencies:
#   "githubot": "0.4.x"
#
# Configuration:
#   HUBOT_GITHUB_TOKEN
#
# Commands:
#   hubot deploy <project_name>(/branch) to <environment> - merges the selected branches or SHA commits into master or develop

module.exports = (robot) ->

  github = require('githubot')(robot, token: '3b025ddf652f334fd2f2d71395f1814c5d3fe474')

  branch_by_environment = {
    production: 'master',
    prod:       'master',
    master:     'master',
    staging:    'develop',
    develop:    'develop',
  }

  robot.respond /deploy ([-_\.0-9a-zA-Z]+)(\/([-_\.a-zA-z0-9\/]+))? to ([-_\.0-9a-zA-Z]+)/i, (msg) ->
    app         = msg.match[1]
    head        = msg.match[3] || 'develop'
    environment = msg.match[4]
    base        = branch_by_environment[environment]
    url         = "https://api.github.com/repos/EmilieP/#{app}/merges"

    github.handleErrors (response) ->
      msg.send "Oups! #{response.error}!"

    github.post url, { base: base, head: head }, (merge) ->
      if merge and merge.commit
        msg.send "Merged #{head} into #{base}"
      else
        msg.send "#{base} already contains #{head}!"
