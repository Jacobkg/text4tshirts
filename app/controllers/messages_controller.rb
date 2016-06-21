class MessagesController < ApplicationController

  def index
    render text: params['hub.challenge']
  end

  def create
    sender_id = params[:sender][:id]
    recipient_id = params[:recipient][:id]
    message = params[:message]
    message_id = params[:message][:id]

    message_text = "Good morning"

    message_data = { recipient: { id: recipient_id },
                     message: { text: message_text } }

    access_token = "EAABv3uAx8isBACGsYUslTzd1a5bHLgSS3dH7YKHHedkasKgcMySe0YaieGfg5aW5HdVZCRmEZBAJwJNhewrrXrVED9ZAC9I4huOaT4uLizJnD4Eo1Y9LQzr9sdfbZCaMPEnClm99V0g8Kr0GJDA76b9FpfZBSiSMRDknHxkp24wZDZD"
    HTTParty.post("https://graph.facebook.com/v2.6/me/messages?access_token=#{access_token}",
      body: message_data.to_json,
      headers: { 'Content-Type' => 'application/json' })
  end

end