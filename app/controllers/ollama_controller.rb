require 'async/websocket/adapters/rails'

class OllamaController < ApplicationController
  RESOLVER = Live::Resolver.allow(OllamaTag)

  def index
    @tag = OllamaTag.new('ollama')
  end

  skip_before_action :verify_authenticity_token, only: :live

  def live
    self.response = Async::WebSocket::Adapters::Rails.open(request) do |connection|
      Live::Page.new(RESOLVER).run(connection)
    end
  end
end
