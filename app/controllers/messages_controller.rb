class MessagesController < ApplicationController

  def index
    render text: params['hub.challenge']
  end

  def create
  end

end