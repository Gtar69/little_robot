str = "LIQUIDCRYSTALDISPLAY 液晶螢幕
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
#p str
regex = /.+\n/
p str.scan(regex)


