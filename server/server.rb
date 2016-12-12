$LOAD_PATH << ENV['LIB_HOME']

require 'grpc'
require 'fortune_pb'
require 'fortune_services_pb'

class FortuneServer < FortuneService::Service
  def initialize
    @cookies = [
      'People are naturally attracted to you.',
      'You learn from your mistakes... You will learn a lot today.'
    ]
  end

  def get_fortune(_request, _call)
    FortuneResponse.new(fortune: @cookies.sample)
  end
end # class FortuneServer

if __FILE__ == $PROGRAM_NAME
  server = GRPC::RpcServer.new
  address = '0.0.0.0:1983'
  server.add_http2_port(address, :this_port_is_insecure)
  server.handle(FortuneServer.new)
  server.run_till_terminated
end
