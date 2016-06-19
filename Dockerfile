FROM httplab/ruby-dev-app:2.3

VOLUME $HOME/$APP

USER $USER

CMD [ "irb" ]
