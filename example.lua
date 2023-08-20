local LIP = require 'LIP';

local dataStr =[[
[sound]
  left=70
  right=80
[screen]
  width=960
  height=550
  caption='Window\'s caption'
  focused=true
]]

-- Data saving
print(LIP.dump(LIP.parse(dataStr)))


print("--coomplete")