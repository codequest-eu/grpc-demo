FROM codequest/grpc-ruby:latest

# Set up proto directory and copy the code there:
ENV PROTO_HOME=/fortune-proto
RUN mkdir $PROTO_HOME
ADD ./proto $PROTO_HOME

# Set up library directory and generate protos:
ENV LIB_HOME=/fortune-lib
RUN mkdir $LIB_HOME
RUN protoc -I $PROTO_HOME \
              --ruby_out=$LIB_HOME \
              --grpc_out=$LIB_HOME \
              --plugin=protoc-gen-grpc=`which grpc_ruby_plugin` \
              $PROTO_HOME/fortune.proto

# Set up app directory:
ENV APP_HOME=/fortune-server
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Add a Gemfile before the rest of the code, for caching purposes:
ADD ./server/Gemfile* $APP_HOME/
RUN bundle install --jobs 10

# Add the rest of the server code:
ADD ./server $APP_HOME

# Clean up installation artifacts:
RUN rm -rf $GRPC_PATH

# Copy CA certificate and server credentials:
ENV KEY_HOME=/.keys
RUN mkdir $KEY_HOME
WORKDIR $KEY_HOME
ADD ./keys/ca.crt $KEY_HOME/
ADD ./keys/server.crt $KEY_HOME/
ADD ./keys/server.key $KEY_HOME/

WORKDIR $APP_HOME
