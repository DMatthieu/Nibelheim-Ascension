Goblin = {}
Goblin.__index = Goblin

function Goblin:new(x, y)
  local instance = setmetatable({}, Goblin)

  instance.x = x
  instance.y = y
  instance.w = 0
  instance.h = 0
  instance.anim = 0
  instance.sp =
    --sprite
    41
  instance.pv = 1
  instance.flp = false
  --states
  instance.alive = true
  instance.dead = false
  -- agro
  instance.agro_radius = 20
  instance.debug_agro = true
  instance.agro_acquired = false

  return instance
end

function Goblin:update()
  --hurt to death
  if self.pv <= 0 then
    self.spr = 0
    sfx(4)
    self:die()
  end

  --animate
  self:animate()

  -- self:check_blade_collisions()
end

function Goblin:draw()
  spr(self.sp, self.x, self.y, 1, 1, self.flp, false)

  -- DEBUG AGRO GOBLINS
  if self.debug_agro then
    if not self.agro_acquired then
      circ(self.x, self.y, self.agro_radius, 11) -- cercle vert
    elseif self.agro_acquired then
      circ(self.x, self.y, self.agro_radius, 8) --cercle rouge
    end
  end
end

--*****************

function Goblin:receive_damage(dmg)
  self.pv -= dmg
end

function Goblin:die()
  self.alive = false
  self.dead = true
end

function Goblin:animate()
  if time() - self.anim > .1 then
    self.anim = time()
    self.sp += 1
    if self.sp > 42 then
      self.sp = 41
    end
  end
end