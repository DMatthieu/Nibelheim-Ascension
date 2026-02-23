Goblin = {}
Goblin.__index = Goblin

function Goblin:new(x, y)
  local instance = setmetatable({}, Goblin)

  instance.x = x
  instance.y = y
  instance.w = 8
  instance.h = 8
  instance.anim = 0

  --physics
  instance.gravity = 0.3
  instance.friction = 0.85
  instance.acc = 0.2
  instance.boost = 3

  instance.dx = 0
  instance.dy = 0
  instance.max_dx = 2
  instance.max_dy = 3
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
  instance.jumping = false
  instance.falling = false
  instance.sliding = false
  instance.climbing = false
  instance.landed = false
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
  self.dy += self.gravity
  self.x += self.dx
  self.y += self.dy

  if self.dy > 0 then
    self.falling = true
    self.landed = false
    self.jumping = false

    self.dy = self:limit_speed(self.dy, self.max_dy)

    if collide_map(self, "down", 0) then
      self.landed = true
      self.falling = false
      self.dy = 0
      self.y -= ((self.y + self.h) % 8)
    end
  elseif self.dy < 0 then
    self.jumping = true
    if collide_map(self, "up", 1) then
      self.dy = 0
    end
  end

  --collide flames
  if collide_map(self, "center", 6) then
    self:receive_damage(1)
    player.score += 1000
  end

  --check collisions left and right
  if self.dx < 0 then
    --if walls
    if collide_map(self, "left", 1) then
      --mob repoussé si il se cogne au mur
      self.dx = self.acc + 1
      sfx(6)
    else
      self.dx = self:limit_speed(self.dx, self.max_dx)
    end
  elseif self.dx > 0 then
    if collide_map(self, "right", 1) then
      --mob repoussé si il se cogne au mur
      self.dx = -self.acc - 1
      sfx(6)
    else
      self.dx = self:limit_speed(self.dx, self.max_dx)
    end
  else
    self.dx = 0
  end

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

function Goblin:limit_speed(num, maximum)
  return mid(-maximum, num, maximum)
end