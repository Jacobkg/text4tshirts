class MessagesController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    render text: params['hub.challenge']
  end

  # {"object"=>"page",
  #  "entry"=>[{"id"=>"1559088657719817", "time"=>1466475527710,
  #            "messaging"=>[
  #             {"sender"=>{"id"=>"1032290006854660"},
  #              "recipient"=>{"id"=>"1559088657719817"},
  #              "timestamp"=>1466474884953,
  #              "message"=>{"mid"=>"mid.1466474884679:eeb908bf78b80bdd95", "seq"=>2, "text"=>"Hi there"}}]}]
  #  "message"=>{"object"=>"page",
  #              "entry"=>[{"id"=>"1559088657719817", "time"=>1466475527710, "messaging"=>[{"sender"=>{"id"=>"1032290006854660"}, "recipient"=>{"id"=>"1559088657719817"}, "timestamp"=>1466474884953, "message"=>{"mid"=>"mid.1466474884679:eeb908bf78b80bdd95", "seq"=>2, "text"=>"Hi there"}}]}]}}
  def create
    recipient_id = params[:entry].first[:messaging].first[:recipient][:id]

    message_text = "Good morning"
    message_data = { recipient: { id: recipient_id },
                     message: { text: message_text } }

    access_token = "EAABv3uAx8isBACGsYUslTzd1a5bHLgSS3dH7YKHHedkasKgcMySe0YaieGfg5aW5HdVZCRmEZBAJwJNhewrrXrVED9ZAC9I4huOaT4uLizJnD4Eo1Y9LQzr9sdfbZCaMPEnClm99V0g8Kr0GJDA76b9FpfZBSiSMRDknHxkp24wZDZD"
    HTTParty.post("https://graph.facebook.com/v2.6/me/messages?access_token=#{access_token}",
      body: message_data.to_json,
      headers: { 'Content-Type' => 'application/json' })

    render status: 200, json: { success: 'yes' }
  end

end