Game_map = {}
Game_map.__index = Game_map

function Game_map:new()
  local instance = setmetatable({}, Game_map)

  instance.monsters = {
    { m_type = Goblin:new(232, 472) },
    { m_type = Goblin:new(46, 320) },
    { m_type = Goblin:new(108, 288) },
    { m_type = Goblin:new(126, 272) },
    { m_type = Goblin:new(200, 288) },
    { m_type = Goblin:new(183, 352) },
    { m_type = Goblin:new(208, 416) },
    { m_type = Goblin:new(423, 432) },
    { m_type = Goblin:new(430, 432) },
    { m_type = Goblin:new(455, 496) },
    { m_type = Goblin:new(448, 496) },
    { m_type = Goblin:new(440, 496) }
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