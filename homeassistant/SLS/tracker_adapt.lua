function track(device, ip)	
  local offline = true
  local attempt = 0
  local max_attempts = 4
  local avg_ping = 0

  fails = obj.get(device)
  if fails == Nil then 
  	obj.set(device, '0')
  elseif tonumber(fails) >= 9 then
    print(device .. ": Call failed for " .. fails .." times. max_attempts will be set to: 1")
    max_attempts = 1
  else
    print(device .. ": Call failed for " .. fails .." times")
  end

  while offline do
    attempt = attempt + 1
  	local result = os.ping(ip)
    -- 1 digit -- result = math.floor(result*10+0.5)/10
    result = math.floor(result+0.5)
    if (result >= 0) then 
      print(device .. ": Ping Ok! AvgTime: " .. result .. " ms. Attempt: " .. attempt)
      offline = false
      avg_ping = avg_ping + result
      obj.set(device, '0')
      print(device .. ": Ping failure resetted!")
    else
      print(device .. ": Ping failed. Attempt: " .. attempt)
      obj.set(device, tostring(fails + 1))
    end
    if (attempt == max_attempts and offline == true) then
      print(device .. ": Ping failed for " .. attempt .." attempts")
      avg_ping = result
      break
    end
    os.delay(2000)
  end
  if (offline == false) then
    avg_ping = avg_ping / attempt
    mqtt.pub('tracker/'.. device ..'', 'home')
  else
    mqtt.pub('tracker/'.. device ..'', 'not_home')
  end
  mqtt.pub('tracker/'.. device ..'/info', '{"ping":'.. avg_ping ..', "ip":"'.. ip ..'", "attempt":'.. attempt ..', "fails":'.. fails ..'}')
end

track("mi9"   , "192.168.1.251")
track("redmi8", "192.168.1.250")