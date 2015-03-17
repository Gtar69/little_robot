class ContentsController < ApplicationController
  require 'nokogiri'
  require 'open-uri'
  require 'rest_client'

  def index
  end

  def parse_url
    url = params[:url]
    user_agent = "Atomz/1.0"
    resource = RestClient.get(url,:referer => "" ,:user_agent => user_agent, :cookies => { _ts_id: "12345678"}).force_encoding("big5")
    File.open("#{Rails.root}/public/robots.txt", "w"){|file| file.write(resource)}
    doc = Nokogiri::HTML(resource)
    #binding.pry
    @title = doc.css('div.auction-data').css('h2').text
    @price = doc.css('div.auction-data').css('li.initiation').text
    iframe_url = ""
    doc.xpath("//iframe").each do |doc|
      if doc.attributes["src"]
        iframe_url = doc.attributes["src"].value unless doc.attributes["src"].value.blank?
      end
    end
    resource = RestClient.get(iframe_url,:referer => url ,:user_agent => user_agent, :cookies => { _ts_id: "12345678"}).force_encoding("big5")
    #File.open("#{Rails.root}/public/robots.txt", "w"){|file| file.write(resource)}
    #f = File.open("#{Rails.root}/public/robots.txt")
    doc = Nokogiri::HTML(resource)
    @array = []
    doc.xpath("//p").each do |doc|
      #p doc.text
      @array << doc.text.gsub(/<h\d>[^>]*>/,'').gsub(/<img[^>]*>/,'').gsub(/<\/?[^>]*>/, '').gsub(/\s/,'')
    end
    render :layout => false
  end

end
