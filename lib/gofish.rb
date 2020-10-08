require 'gofish/version'
require 'gofish/game'
require 'gofish/player'
require 'sinatra'
require 'sinatra/json'
require 'singleton'

post '/games' do
  players =
    params[:players]&.map do |player_name|
      Gofish::Player.new(name: player_name, cards: [])
    end

  instance = Gofish::Game.new(deck_id: '', players: players)

  instance.submit_to_api!
  instance.distribute_cards!

  json({ players: params[:players] })
end

get '/games/:game_id/players/:player_name' do
  game_id = params['game_id']
  result =
    RestClient.get(
      "https://deckofcardsapi.com/api/deck/#{game_id}/draw/?count=4"
    )

  if result.code.eql?(200)
    cards = JSON.parse(result.body).fetch('cards')
  else
    cards = []
  end

  json({ cards: cards })
end

post '/games/{gameId}/players/{playerName}/fish' do
end
