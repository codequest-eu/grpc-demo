require 'fortune_pb'
require 'fortune_services_pb'

class FortuneController < ApplicationController
  def show
    @cookie = client.get_fortune(FortuneRequest.new).fortune
  end

  private

  def client
    @client ||=
      FortuneService::Stub
      .new('server:1983', :this_channel_is_insecure)
  end
end # class FortuneController
