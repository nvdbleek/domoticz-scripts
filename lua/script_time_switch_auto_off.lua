-- This script turns off lights after the configured amount of time
--  switches should be named '{name} auto_off {n}'

defaultMaxTime = 15 * 60

function timedifference(s)
   year = string.sub(s, 1, 4)
   month = string.sub(s, 6, 7)
   day = string.sub(s, 9, 10)
   hour = string.sub(s, 12, 13)
   minutes = string.sub(s, 15, 16)
   seconds = string.sub(s, 18, 19)
   t1 = os.time()
   t2 = os.time{year=year, month=month, day=day, hour=hour, min=minutes, sec=seconds}
   print(t1)
   print(t2)
   difference = os.difftime (t1, t2)
   print(difference)
   return difference
end


commandArray = {}

for i, v in pairs(otherdevices) do
  if (string.find(i, ' auto_off ')) then
    index = string.find(i, ' auto_off ');
    maxTime = defaultMaxTime
    maxTimeStr = i:sub(index + 10)

    if (maxTimeStr ~= (nil or '')) then
      maxTime = tonumber(maxTimeStr) * 60
    end
    difference = timedifference(otherdevices_lastupdate[i])
    if (v == 'On' and difference > maxTime) then
        commandArray[i]='Off'
        commandArray['SendNotification']='Automatically turning off light ' .. i:sub(1, index - 1)
    end
  end
end

return commandArray