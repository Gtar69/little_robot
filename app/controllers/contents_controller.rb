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

  def parse_str
    #binding.pry
    str = "LIQUIDCRYSTALDISPLAY 
    液晶螢幕
鏡頭尺寸 LENS 
170°A+HDwide-anglelens,6Glens超廣角
語言 LANGUAGEOPTIONS 
English/German/French/Spanish/Italian/Portuguese/ChineseTraditional/ChineseSimplified/Japanese/Russian
錄影解析度 RESOLUTIONOFVIDEOSRECORDED
1080P(1920*1080)30FPS 720P(1280*720)60FPS VGA(848*480)60FPS QVGA(640*480)60FPS
影像規格 VIDEOFORMAT
MOV
影片壓縮規格 COMPRESSEDFORMATOFVIDEOS
H.264
照相解析度 RESOLUTIONOFPHOTOS
12M/8M/5M
適用記憶卡規格 STORAGE
MicroSD 
拍照模式 SHOOTINGMODE
SingleShot/Self-timer(2s/5s/10s/ContinuousShooting
拍照頻率 FREQUENCYOFOPTICALSOURCE
50Hz/60Hz
USB介面 USBINTERFACE
USB2.0
電壓 POWERSOURCEINTERFACE
5V1A
電池容量 BATTERYCAPACITY
900MAH 400mA@4.2V
可記錄時間 RECORDINGTIME
1080P/About70minutes
充電所需時間 CHARGINGTIME
About3.5hours
可相容作業系統 OPERATINGSYSTEM(OS)
WindowsXP/VistaorAbove/Win7/Macos
尺寸 DIMENSION
59.27*41.13*29.28
"

    str = str.force_encoding("UTF-8")
    regex = /.+\n/
    p str.scan(regex)
    #binding.pry
    @spec = str.scan(regex)
    render :layout => false
  end

end
