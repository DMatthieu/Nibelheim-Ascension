Game_map = {}
Game_map.__index = Game_map

function Game_map:new()
  local instance = setmetatable({}, Game_map)

  instance.monsters = {
    { m_type = Goblin:new(367, 496) },
    { m_type = Goblin:new(350, 496) }
  }
  return instance
end

function Game_map:update()
  --update all monsters
  for m in all(self.monsters) do
    m.m_type:update()
  end
end

function Game_map:draw()
  map(0, 0, 0, 0)

  --draw all monsters
  for m in all(self.monsters) do
    m.m_type:draw()
  end
end