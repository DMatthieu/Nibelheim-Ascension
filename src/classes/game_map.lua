Game_map = {}
Game_map.__index = Game_map

function Game_map:new()
  local instance = setmetatable({}, Game_map)

  return instance
end

function Game_map:draw()
  map(0,0,0,0)
end