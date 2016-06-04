wifi.setmode(wifi.STATION)
wifi.sta.config("Acesspoint","password")
print(wifi.sta.getip())

DeviceID="esp01"  
RoomID="1"


Broker="IP address of MQTT broker"
--GPIO2 is connected to LED via resistor, initially off 
 gpio.mode(1,gpio.OUTPUT) 
 gpio.write(1,gpio.LOW) 
 gpio.mode(2,gpio.OUTPUT) 
 gpio.write(2,gpio.LOW) 
 gpio.mode(3,gpio.OUTPUT) 
 gpio.write(3,gpio.LOW) 
 gpio.mode(4,gpio.OUTPUT) 
 gpio.write(4,gpio.HIGH) 
 gpio.mode(5,gpio.OUTPUT) 
 gpio.write(5,gpio.LOW) 
 gpio.mode(6,gpio.OUTPUT) 
 gpio.write(6,gpio.LOW) 
 gpio.mode(7,gpio.OUTPUT) 
 gpio.write(7,gpio.LOW)

 m = mqtt.Client("KITCHEN"..DeviceID, 180, "user", "password") 
 m:lwt("/lwt", "ESP8266", 0, 0) 
 m:on("offline", function(con) 
 print ("Mqtt Reconnecting...") 
 tmr.alarm(1, 10000, 0, function() 
 m:connect(Broker, 1883, 0, function(conn) 
 print("Mqtt Connected to:" .. Broker) 
 mqtt_sub() --run the subscription function 
 end) 
 end) 
 end)
-- on publish message receive event 
 m:on("message", function(conn, topic, data) 
 print("Recieved:" .. topic .. ":" .. data) 
 if (data=="ON") and (topic=="/home/".. RoomID .."/" .. DeviceID .. "/p1/com") then 
 print("Enabling Output") 
 gpio.write(1,gpio.HIGH) 
 m:publish("/home/".. RoomID .."/" .. DeviceID .. "/p1/state","NO",0,0) 
 elseif (data=="OFF") and (topic=="/home/".. RoomID .."/" .. DeviceID .. "/p1/com") then 
 print("Disabling Output") 
 gpio.write(1,gpio.LOW) 
 m:publish("/home/".. RoomID .."/" .. DeviceID .. "/p1/state","OFF",0,0)

elseif (data=="ON") and (topic=="/home/".. RoomID .."/" .. DeviceID .. "/p2/com") then 
 print("Enabling Output") 
 gpio.write(2,gpio.HIGH) 
 m:publish("/home/".. RoomID .."/" .. DeviceID .. "/p2/state","ON",0,0) 
 elseif (data=="OFF") and (topic=="/home/".. RoomID .."/" .. DeviceID .. "/p2/com") then 
 print("Disabling Output") 
 gpio.write(2,gpio.LOW) 
 m:publish("/home/".. RoomID .."/" .. DeviceID .. "/p2/state","OFF",0,0)

elseif (data=="ON") and (topic=="/home/".. RoomID .."/" .. DeviceID .. "/p3/com") then 
 print("Enabling Output") 
 gpio.write(3,gpio.HIGH) 
 m:publish("/home/".. RoomID .."/" .. DeviceID .. "/p3/state","ON",0,0) 
 elseif (data=="OFF") and (topic=="/home/".. RoomID .."/" .. DeviceID .. "/p3/com") then 
 print("Disabling Output") 
 gpio.write(3,gpio.LOW) 
 m:publish("/home/".. RoomID .."/" .. DeviceID .. "/p3/state","OFF",0,0)

elseif (data=="ON") and (topic=="/home/".. RoomID .."/" .. DeviceID .. "/p4/com") then 
 print("Enabling Output") 
 gpio.write(4,gpio.HIGH) 
 m:publish("/home/".. RoomID .."/" .. DeviceID .. "/p4/state","ON",0,0) 
 elseif (data=="OFF") and (topic=="/home/".. RoomID .."/" .. DeviceID .. "/p4/com") then 
 print("Disabling Output") 
 gpio.write(4,gpio.LOW) 
 m:publish("/home/".. RoomID .."/" .. DeviceID .. "/p4/state","OFF",0,0)

elseif (data=="ON") and (topic=="/home/".. RoomID .."/" .. DeviceID .. "/p5/com") then 
 print("Enabling Output") 
 gpio.write(5,gpio.HIGH) 
 m:publish("/home/".. RoomID .."/" .. DeviceID .. "/p5/state","ON",0,0) 
 elseif (data=="OFF") and (topic=="/home/".. RoomID .."/" .. DeviceID .. "/p5/com") then 
 print("Disabling Output") 
 gpio.write(5,gpio.LOW) 
 m:publish("/home/".. RoomID .."/" .. DeviceID .. "/p5/state","OFF",0,0)

elseif (data=="ON") and (topic=="/home/".. RoomID .."/" .. DeviceID .. "/p6/com") then 
 print("Enabling Output") 
 gpio.write(6,gpio.HIGH) 
 m:publish("/home/".. RoomID .."/" .. DeviceID .. "/p6/state","ON",0,0) 
 elseif (data=="OFF") and (topic=="/home/".. RoomID .."/" .. DeviceID .. "/p6/com") then 
 print("Disabling Output") 
 gpio.write(6,gpio.LOW) 
 m:publish("/home/".. RoomID .."/" .. DeviceID .. "/p6/state","OFF",0,0)

elseif (data=="ON") and (topic=="/home/".. RoomID .."/" .. DeviceID .. "/p7/com") then 
 print("Enabling Output") 
 gpio.write(7,gpio.HIGH) 
 m:publish("/home/".. RoomID .."/" .. DeviceID .. "/p7/state","ON",0,0) 
 elseif (data=="OFF") and (topic=="/home/".. RoomID .."/" .. DeviceID .. "/p7/com") then 
 print("Disabling Output") 
 gpio.write(7,gpio.LOW) 
 m:publish("/home/".. RoomID .."/" .. DeviceID .. "/p7/state","OFF",0,0) 
 end 
 end) 
 function mqtt_sub() 
 m:subscribe("home/1/esp01/#",0, function(conn) 
 print("Mqtt Subscribed to OpenHAB feed for device "..DeviceID) 
 end) 
 end 
 tmr.alarm(0, 1000, 1, function() 
 if wifi.sta.status() == 5 and wifi.sta.getip() ~= nil then 
 tmr.stop(0) 
 m:connect(Broker, 1883, 0, function(conn) 
 print("Mqtt Connected to:" .. Broker) 
 mqtt_sub() --run the subscription function 
 end) 
 end 
 end)
