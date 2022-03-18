function track(device, ip)
  local offline = true
  local attempt = 0
  local max_attempts = 3
  local avg_ping = 0

  while offline do
    attempt = attempt + 1
  	local result = os.ping(ip)
    if (result >= 0) then 
      print(device .. ": Ping Ok! AvgTime: " .. result .. " ms. Attempt: " .. attempt)
      offline = false
      avg_ping = avg_ping + result
    else
      print(device .. ": Ping failed. Attempt: " .. attempt)
    end
    if (attempt == max_attempts and offline == true) then
      print(device .. ": Ping failed for " .. attempt .." attempts")
      avg_ping = result
      break
    end
    --sleep(5)
  end
  if (offline == false) then
    avg_ping = avg_ping / attempt
    mqtt.pub('tracker/'.. device ..'', 'home')
  else
    mqtt.pub('tracker/'.. device ..'', 'not_home')
  end
  mqtt.pub('tracker/'.. device ..'/info', '{"ping":'.. avg_ping ..', "ip":"'.. ip ..'", "attempt":'.. attempt ..'}')
end

function sleep(n)
  --print("sleep")
  local t = os.time()
  while os.time() - t <= n do
    -- nothing
  end
end

track("mi9"   , "192.168.1.251")
track("redmi8", "192.168.1.250")