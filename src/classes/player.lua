Player = {}
Player.__index = Player

function Player:new()
  local instance = setmetatable({}, Player)

  instance.sp = 9
  instance.x = 64
  instance.y = 64
  instance.w = 8
  instance.h = 8
  instance.flp = false
  instance.dx = 0
  instance.dy = 0
  instance.max_dx = 2
  instance.max_dy = 3
  instance.acc = 0.5
  instance.boost = 4
  instance.anim = 0
  instance.running = false
  instance.jumping = false
  instance.falling = false
  instance.sliding = false
  instance.landed = false

  instance.gravity = 0.3
  instance.friction = 0.85

  --camera
  instance.cam_x = 0

  return instance
end

function Player:update()
  --camera
  self.cam_x = self.x -64
  self.cam_y = self.y -64
  camera(self.cam_x, self.cam_y)
  --physics
  self.dy += self.gravity
  self.dx *= self.friction

  --controls
  --left
  if btn(0) then
    self.dx -= self.acc
    self.running = true
    self.flp = true
  end
  if btn(1) then
    self.dx += self.acc
    self.running = true
    self.flp = false
  end

  --slide
  if self.running
  and not btn(0)
  and not btn(1)
  and not self.falling
  and not self.jumping then
    self.running = false
    self.sliding = true
  end

  --jump
  if btnp(5)
  and self.landed then
    self.dy -= player.boost
    self.landed = false
  end

  --check collisions up and down
  if self.dy>0 then
    self.falling = true
    self.landed = false
    self.jumping = false

    self.dy = self:limit_speed(self.dy, self.max_dy)

    if collide_map(player, "down", 0) then
      self.landed = true
      self.falling = false
      self.dy = 0
      self.y -= (self.y + self.h)%8
    end

  elseif self.dy < 0 then
    self.jumping = true
    if collide_map(player, "up", 1) then
      self.dy = 0
    end
  end

  --check collisions left and right
  if self.dx < 0 then

    self.dx = self:limit_speed(self.dx, self.max_dx)

    if collide_map(player, "left", 1) then
      self.dx = 0
    end
  elseif self.dx > 0 then

    self.dx = self:limit_speed(self.dx, self.max_dx)

    if collide_map(player, "right", 1) then
      self.dx = 0
    end
  end

  --stop sliding
  if self.sliding then
    if abs(self.dx)<.2
    or self.running then
      self.dx = 0
      self.sliding = false
    end
  end

  self.x += self.dx
  self.y += self.dy


end

function Player:draw()
  spr(self.sp, self.x, self.y, 1, 1, self.flp, false )
end

--******************

-- function Player:move()
--   if btn(0) then self.x -= self.dx end
--   if btn(1) then self.x += self.dx end
-- end

function Player:animate()
  if self.jumping then
    player.sp=26
  elseif self.falling then
    self.sp=27
  elseif self.sliding then
    self.sp=13
  elseif self.running then
    if time() - self.anim > .1 then
      self.anim = time()
      self.sp += 1
      if self.sp > 14 then
        self.sp = 11
      end
    end
  else --idle
    if time() - self.anim > .3 then
      self.anim = time()
      self.sp += 1
      if self.sp > 10 then
        self.sp = 9
      end
    end
  end
end

function Player:limit_speed(num, maximum)
  return mid(-maximum, num, maximum)
end
