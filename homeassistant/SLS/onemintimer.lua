function track(name, device, ip)	
  local offline = true
  local attempt = 0
  local max_attempts = 3
  local avg_ping = 0

  fails = obj.get(name)
  if fails == Nil then 
    obj.set(name, '0')
    fails = 0
  elseif tonumber(fails) >= 9 then
    print(name .. " - " .. device .. ": Call failed for " .. fails .." times. max_attempts will be set to: 1")
    max_attempts = 1
  else
    print(name .. " - " .. device .. ": Call failed for " .. fails .." times")
  end

  while offline do
    attempt = attempt + 1
  	local result = os.ping(ip)
    -- 1 digit -- result = math.floor(result*10+0.5)/10
    result = math.floor(result+0.5)
    if (result >= 0) then 
      print(name .. " - " .. device .. ": Ping Ok! AvgTime: " .. result .. " ms. Attempt: " .. attempt)
      offline = false
      avg_ping = avg_ping + result
      obj.set(name, '0')
      print(name .. " - " .. device .. ": Ping failure resetted!")
    else
      print(name .. " - " .. device .. ": Ping failed. Attempt: " .. attempt)
      obj.set(device, tostring(fails + 1))
    end
    if (attempt == max_attempts and offline == true) then
      print(name .. " - " .. device .. ": Ping failed for " .. attempt .." attempts")
      avg_ping = result
      break
    end
    --os.delay(4000)
  end
  if (offline == false) then
    avg_ping = avg_ping / attempt
    mqtt.pub('tracker/'.. name ..'', 'home')
  else
    mqtt.pub('tracker/'.. name ..'', 'not_home')
  end
  mqtt.pub('tracker/'.. name ..'/info', '{"device":"'.. device ..'", "ping":'.. avg_ping ..', "ip":"'.. ip ..'", "attempt":'.. attempt ..', "fails":'.. fails ..'}')
end

track("mobile_mario", "Xioami Mi9", "192.168.1.79")
track("mobile_maria", "Oppo A94", "192.168.1.183")