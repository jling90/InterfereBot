require 'sinatra'
require 'pry'
require 'json'
require 'slack-ruby-client'
require 'dotenv/load'

class Frank < Sinatra::Base
  before do
    @request_payload = JSON.parse request.body.read
  end

  get '/' do
    'Frasnk'
  end

  post '/' do
    body @request_payload['challenge']
  end

  token = ENV['SLACK_API_TOKEN']
  client = Slack::RealTime::Client.new(token: token)

  client.on(:user_typing) do |data|
    logger.info data
    client.typing channel: data.channel
  end

  client.start_async
end

