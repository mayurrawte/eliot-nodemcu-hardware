station_cfg = {}
station_cfg.ssid="Wireless_Gangbang"
station_cfg.pwd = "Ewqdsacxz"
wifi.sta.config(station_cfg)
wifi.sta.connect()
print(wifi.sta.gethostname())
print(wifi.sta.getip())
print(wifi.sta.getrssi())

gpio.mode(1,gpio.OUTPUT)

id = node.chipid()


m = mqtt.Client("clientid", 120)

-- init mqtt client with logins, keepalive timer 120sec
m = mqtt.Client("clientid", 120, "user", "password")

-- setup Last Will and Testament (optional)
-- Broker will publish a message with qos = 0, retain = 0, data = "offline" 
-- to topic "/lwt" if client don't send keepalive packet
m:lwt("/lwt", "offline", 0, 0)

m:on("connect", function(client) print ("connected") end)
m:on("offline", function(client) print ("offline") end)

-- on publish message receive event
m:on("message", function(client, topic, data) 
  print(topic .. ":" ) 
  if data ~= nil then
    print(data)
    tb = cjson.decode(data)
    for k,v in pairs(tb) do print(k,v)
            if v == "true" 
            then
            gpio.write(k,gpio.HIGH)
            else
            gpio.write(k,gpio.LOW)
            end
    end
    
  end
end)

-- for TLS: m:connect("192.168.11.118", secure-port, 1)
m:connect("iot.eclipse.org", 1883, 0, function(client) 
m:subscribe("topic/shambhu/testing",0, function(client) print("subscribe success") end)
end, 
function(client, reason) print("failed reason: "..reason) end)

-- Calling subscribe/publish only makes sense once the connection
-- was successfully established. In a real-world application you want
-- move those into the 'connect' callback or make otherwise sure the 
-- connection was established.

-- subscribe topic with qos = 0

-- publish a message with data = hello, QoS = 0, retain = 0


m:close();
