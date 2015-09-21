# Description:
#   Manage your Trello Board from Hubot!
#
# Dependencies:
#   "node-trello": "latest"
#
# Configuration:
#   HUBOT_TRELLO_KEY - Trello application key
#   HUBOT_TRELLO_TOKEN - Trello API token
#   HUBOT_TRELLO_BOARD - The ID of the Trello board you will be working with
#
# Commands:
#   hubot trello new "<list>" <name> - Create a new Trello card in the list
#   hubot trello list "<list>" - Show cards on list
#   hubot trello move <shortLink> "<list>" - Move a card to a different list
#
#
# Author:
#   jared barboza <jared.m.barboza@gmail.com>

Trello = require('node-trello')
trello = new Trello('f7ebd26d9eb180538da9a26b1a764918', '7e79b210a63564c57d88a6cae7b1385e7e6fd84297da6be7e97d5f17c34464cf')

board = { 'test nono': 'ITkZ01q' }
lists = {}


showCards = (msg, list_name) ->
  msg.reply "Looking up the cards for #{list_name}, one sec."
  id = lists[list_name.toLowerCase()].id
  msg.send "I couldn't find a list named: #{list_name}." unless id
  if id
    trello.get "/1/lists/#{id}", { cards: "open" }, (err, data) ->
      msg.reply "There was an error showing the list." if err
      msg.reply "Here are all the cards in #{data.name}:" unless err and data.cards.length == 0
      msg.send "* [#{card.shortLink}] #{card.name} - #{card.shortUrl}" for card in data.cards unless err and data.cards.length == 0
      msg.reply "No cards are currently in the #{data.name} list." if data.cards.length == 0 and !err

module.exports = (robot) ->

  trello.get "/1/boards/ITkZ01qE/lists", (err, data) ->
    for list in data
      lists[list.name.toLowerCase()] = list

  robot.respond /trello list lists/i, (msg) ->
    msg.reply "Here are all the lists on your board."
    Object.keys(lists).forEach (key) ->
      msg.send " * " + key

  robot.respond /trello list ["'](.+)["']/i, (msg) ->
    showCards msg, msg.match[1]
