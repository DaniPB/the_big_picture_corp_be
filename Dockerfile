FROM ruby:3.2.2

ADD . /the_big_picture_corp_be_docker
WORKDIR /the_big_picture_corp_be_docker
RUN bundle install

EXPOSE 3000

CMD ["bash"]
