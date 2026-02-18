Game_map = {}
Game_map.__index = Game_map

function Game_map:new()
  local instance = setmetatable({}, Game_map)

  instance.monsters = {
    { m_type = Goblin:new(367, 498) },
    { m_type = Goblin:new(307, 498) },
    { m_type = Goblin:new(24, 418) },
    { m_type = Goblin:new(202, 378) },
    { m_type = Goblin:new(203, 450) }
  }
  return instance
end

function Game_map:update()
  --update all monsters
  for m in all(self.monsters) do
    --update monsters
    m.m_type:update()
    if m.m_type.dead then
      del(self.monsters, m)
    end
  end
end

function Game_map:draw()
  map(0, 0, 0, 0)

  --draw all monsters
  for m in all(self.monsters) do
    m.m_type:draw()
  end
end