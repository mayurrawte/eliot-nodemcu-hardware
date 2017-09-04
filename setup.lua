local module = {}

local function wifi_wait_ip()
    if wifi.sta.getip() == nil then
        print("IP unavailable,waiting")
    else
        tmr.stop(1)
        print("\n==================")
        print("nodmcu mode is "..wifi.getmode())
        print("MAC address is "..wifi.ap.getmac())
        print("IP is ".. wifi.sta.getip())
        print("==========================")
        app.start()
     end
   end

local function wifi_start(list_aps)
    if list_aps then
        for key,value in pairs(list_aps) do
            if config.SSID and config.SSID[key] then
                wifi.setmode(wifi.STATION);
                wifi.sta.config(key,config.SSID[key])
                wifi.sta.connect()
                print("connecting to "..key.."....")
                tmr.alarm(1,2500,1,wifi_wait_ip)
              end
         end
      end
        print("Error gettting ap")
     end
   end


function module.start()
    print("connecting wifi....")
    wifi.setmode(wifi.STATION)
    wifi.sta.getap(wifi_start)
  end

return module
