# Description:
#   Emma Stone is summoned to your pleasant surprise
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_EMMA_STONE_JARGON comma-separated list of additional "tiggers"
#   HUBOT_EMMA_STONE_OMITTED_JARGON comma-separated list of triggers to ignore
#
# Notes:
#   See jargon array for list of trigger phrases
#

images = require './data/images.json'
jargon = require './data/triggers.json'

removeTerm = (term, arrayToDeleteFrom) ->
  index = arrayToDeleteFrom.indexOf term
  if index > -1
    arrayToDeleteFrom.splice index, 1
    return arrayToDeleteFrom

if process.env.HUBOT_EMMA_STONE_JARGON?
  additionalJargon = (process.env.HUBOT_EMMA_STONE_JARGON).split(',')
  jargon = jargon.concat(additionalJargon)

if process.env.HUBOT_EMMA_STONE_OMITTED_JARGON?
  omittedJargon = (process.env.HUBOT_EMMA_STONE_OMITTED_JARGON).split(',')
  jargon = removeTerm(term, jargon) for term in omittedJargon

regex = new RegExp jargon.join('|'), 'gi'

module.exports = (robot) ->
  robot.hear regex, (msg) ->
    msg.send msg.random images
