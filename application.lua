local module = {}
m = nil 


local function send_ping()
    m:publish(config.ENDPOINT .. "ping","id=" .. config.ID,0,0)
  end


local function register_myself()
    m:subscribe(config.ENDPOINT .. config.ID,0,function(conn)
            print("sucessfullu subscribed to endpoint")
       end)

    end

local function mqtt_start()
    m = mqtt.Client(config.ID,120)

    m:on("message",function(conn,topic,data)
    if data ~=nil then
        print(topic..":"..data)
    end
    end)


    m:connect(config.HOST, config.PORT,0,1 function(con)
        register_myself()
        tmr.stop(6)
        tmr.alarm(6,1000,1,send_ping)
       end)
    end

function module.start()
    mqtt_start()
end

return module