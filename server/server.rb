$LOAD_PATH << ENV['LIB_HOME']

require 'grpc'
require 'fortune'
require 'fortune_services'

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
  credentials = GRPC::Core::ServerCredentials.new(
    File.read('/.keys/ca.crt'), # pem_root_certs
    [{
      private_key: File.read('/.keys/server.key'),
      cert_chain: File.read('/.keys/server.crt')
    }],
    true # force client authentication
  )
  server = GRPC::RpcServer.new
  address = '0.0.0.0:1983'
  server.add_http2_port(address, credentials)
  server.handle(FortuneServer.new)
  server.run_till_terminated
end
