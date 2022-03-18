-- https://slsys.github.io/Gateway/lua_rus.html
function track(name, ip)
  local result = os.ping(ip)
  if (result >= 0) then 
    print(name .. ": Ping Ok! AvgTime: " .. result .. " ms")
    --mqtt.pub('tracker/'.. name ..'', '{"status":"online","ping":'.. result ..',"ip":"'.. ip ..'"}')
  else
    print(name .. ": Ping failed")
    --mqtt.pub('tracker/'.. name ..'', '{"status":"offline","ping":'.. result ..',"ip":"'.. ip ..'"}')
  end
end

track("mi9", "192.168.1.79")
track("a94", "192.168.1.183")