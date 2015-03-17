class ContentsController < ApplicationController
  require 'nokogiri'
  require 'open-uri'
  require 'rest_client'
  #require 'tradsim'

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
    @doc = Nokogiri::HTML(resource)
    @array = []
    p @doc.xpath("//p").count
    @doc.xpath("//p").each do |doc|
      aaa = doc.text.unpack("C*").pack("U*")
      #p aaa.set_encoding("utf-8","big-5")
      #p aaa.encode("UTF-8", "iso8859-1")
      #bbb = aaa.encode("iso8859-1","utf-8")
      #p bbb.encoding
      #p bbb.force_encoding('unicode')
      @array << aaa.force_encoding('iso8859-1')
      #converted_text = Iconv.civ
      #puts Tradsim::to_trad(aaa)
      #aaa.encode("Unicode")
      #ec1 = Encoding::Converter.new "UTF-8","Big-5",:invalid=>:replace,:undef=>:replace,:replace=>""
      #ec2 = Encoding::Converter.new "Big-5","Unicode",:invalid=>:replace,:undef=>:replace,:replace=>""
      #aaa = ec2.convert ec1.convert aaa
      #
    end
    #ec1 = Encoding::Converter.new "UTF-8","Windows-1251",:invalid=>:replace,:undef=>:replace,:replace=>""
    #ec2 = Encoding::Converter.new "Windows-1251","UTF-8",:invalid=>:replace,:undef=>:replace,:replace=>""
    #doc = ec2.convert ec1.convert doc
    render :layout => false
  end

end
