class ContentsController < ApplicationController
  require 'nokogiri'
  require 'open-uri'


  def index
  end

  def parse_url
    url = params[:url]
    user_agent = "Atomz/1.0"
    @doc = Nokogiri::HTML(open(url, 'User-Agent' => user_agent))
    p @doc.css('img').count

    @doc.css('img').each do |img|
      p img
    end
  end

end
