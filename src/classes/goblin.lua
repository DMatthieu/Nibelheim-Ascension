Goblin = {}
Goblin.__index = Goblin

function Goblin:new(x, y)
  local instance = setmetatable({}, Goblin)

  instance.x = x
  instance.y = y
  instance.w = 0
  instance.h = 0
  instance.anim = 0

  --physics
  instance.gravity = 0.3
  instance.friction = 0.85
  instance.acc = 0.2
  instance.boost = 3

  instance.dx = 0
  instance.dy = 0
  instance.go_to_left = false
  instance.go_to_right = false
  --sprite
  instance.sp = 41

  instance.pv = 1
  instance.flp = false
  --states
  instance.alive = true
  instance.dead = false
  instance.running = false
  -- agro
  instance.agro_radius = 20
  instance.debug_agro = false
  instance.agro_acquired = false

  return instance
end

function Goblin:update()
  --hurt to death
  if self.pv <= 0 then
    self.spr = 0
    sfx(5)
    self:die()
  end

  --animate
  self:animate()

  --physics
  --self.dy += self.gravity
  self.dx *= self.friction

  self.x += self.dx
  self.y += self.dy

  -- ***** ORDER MACHINE ****
  -- ORDER: Go to LEFT or RIGHT
  if self.go_to_left then
    self.dx -= self.acc
    self.running = true
    self.flp = true
  elseif self.go_to_right then
    self.dx += self.acc
    self.running = true
    self.flp = false
  else
    self.running = false
  end
  --****************

  -- check agro with player
  if sphere_collide_sphere(self, player) then
    self.agro_acquired = true
  end

  if spr_object_collide_spr_object(self, player) then
    if self.agro_acquired then
      player:damage(1)
    end
  end

  --Si agro acquis...
  if self.agro_acquired then
    --Suit le joueur du regard...
    if player.x < self.x then
      self.flp = true
      self.go_to_left = true
      self.go_to_right = false
    elseif player.x > self.x then
      self.flp = false
      self.go_to_left = false
      self.go_to_right = true
    end
  end
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
  if self.pv <= 0 then
    self.alive = false
    self.dead = true
  end
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