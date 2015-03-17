class ContentsController < ApplicationController
  require 'nokogiri'
  require 'open-uri'
  require 'rest_client'

  def index
  end

  def parse_url
    url = params[:url]
    user_agent = "Atomz/1.0"
    resource = RestClient.get(url,:referer => "" ,:user_agent => user_agent, :cookies => { _ts_id: "12345678"})
    File.open("#{Rails.root}/public/robots.txt", "w"){|file| file.write(resource)}
    @doc = Nokogiri::HTML(resource)
    @doc.xpath("//iframe").each do |doc|
      if doc.attributes["src"]
        @good = doc.attributes["src"].value unless doc.attributes["src"].value.blank?
      end   
    end
    p @good
    resource = RestClient.get(@good,:referer => url ,:user_agent => user_agent, :cookies => { _ts_id: "12345678"})
    File.open("#{Rails.root}/public/robots.txt", "w"){|file| file.write(resource)}
    f = File.open("#{Rails.root}/public/robots.txt")

    @doc = Nokogiri::HTML(resource, nil, 'UTF-8')
    @array = []
    p @doc.xpath("//p").count
    @doc.xpath("//p").each do |doc| 
    #  p doc.text.encode("UTF-8")
      @array << doc.text
    end

  end

end
