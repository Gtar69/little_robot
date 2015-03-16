class ContentsController < ApplicationController
  require 'nokogiri'
  require 'open-uri'
  require 'rest_client'

  def index
  end

  def parse_url
    url = params[:url]
    @url = params[:url]
    user_agent = "Atomz/1.0"
    resource = RestClient.get @url, :user_agent => " user_agent"
    @doc = Nokogiri::HTML(resource)
    p @doc.class
    p @doc
    #p @doc.xpath('//li').count
  end

end
