FROM registry.redhat.io/ubi8/ruby-25:latest
RUN gem install bunny --no-rdoc
COPY ./get_pi.rb /opt/app-root/src/

CMD ["/usr/bin/ruby", "/opt/app-root/src/get_pi.rb"]
