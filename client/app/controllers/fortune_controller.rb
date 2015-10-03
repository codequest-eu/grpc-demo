require 'fortune'
require 'fortune_services'

class FortuneController < ApplicationController
  def show
    credentials = GRPC::Core::Credentials.new(
      File.read('/.keys/server.crt'),
      File.read('/.keys/client.key'),
      File.read('/.keys/client.crt')
    )
    @client = FortuneService::Stub.new('server:1983', creds: credentials)
    @cookie = @client.get_fortune(FortuneRequest.new).fortune
  end
end # class FortuneController
