FROM ubi8/ruby-25:latest
RUN gem install bunny --no-rdoc
ADD ./get_pi.rb

CMD ["/usr/bin/ruby", "/opt/app-root/src/get_pi.rb"]
