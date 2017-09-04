gpio.mode(1,gpio.INPUT)
status = gpio.read(1)
print(status)

function dowhile()
    if(gpio.read(1) == 1) then
        if (flag == 1) then
            print("High")
            flag = 0
        end
     elseif(gpio.read(1) == 0) then
         if (flag == 0) then
            flag = 1
            print("low")
         end
     end
end

mytimer = tmr.create()
mytimer:register(1000,tmr.ALARM_AUTO,dowhile)
mytimer:start()



