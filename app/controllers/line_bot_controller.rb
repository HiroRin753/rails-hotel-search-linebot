class LineBotController < ApplicationController

  protect_from_forgery except: [:callback]

  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
     unless client.validate_signature(body, signature)
       return head :bad_request
     end
    # request.bodyとすることでリクエストのメッセージボディだけを参照することができる。request.bodyはStringIOクラスという、文字列を操作するための様々なメソッドを提供しているクラスの値になっている。このままではメッセージボディの内容を解析できないので、StringIOクラスのreadメソッドを用いて、文字列として読み出し、body変数に代入している。


  end

  private

  # Line::Bot::Clientクラスをインスタンス化することで、メッセージの解析や返信などの機能を使うことができるようになる
  def client
    @client ||= Line::Bot::Client.new { |config|  #||=は左辺がnilやfalseの場合、右辺を代入するという意味
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end
end
