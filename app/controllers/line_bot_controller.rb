class LineBotController < ApplicationController

  protect_from_forgery except: [:callback]

  def callback

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
