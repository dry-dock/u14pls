FROM ankul/u14:prod

ADD . /u14pls
RUN /u14pls/install.sh
