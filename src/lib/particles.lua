Particles = {}
Particles.__index = Particles

function Particles:new()
  local instance = setmetatable({}, Particles)

  instance.spr = 1
  instance.x = 0
  instance.y = 0
  instance.dx = 0
  instance.dy = 0
  instance.spd = 1

  instance.time = 0

  instance.particles = {}

  return instance
end

function Particles:draw_particles()
  for particle in all(self.particles) do
    pset(particle.x, particle.y, particle.col)
  end
end

function Particles:update_particles()
  for particle in all(self.particles) do
    --physics
    particle.x += particle.dx
    particle.y += particle.dy

    --lifespan
    particle.current_lifetime += 1 / 30 -- if update 30 .....
    if particle.current_lifetime > particle.max_lifetime then
      del(self.particles, particle)
    end
  end
end

-- ************************************

function Particles:make_particles(nb, x, y)
  while (nb > 0) do
    particle = {}
    particle.x = x
    particle.y = y
    particle.col = 8
    particle.dx = rnd(2) - 1 --valeur entre -1 et 1
    particle.dy = rnd(2) --valeur entre -1 et 1
    particle.max_lifetime = rnd(3)
    particle.current_lifetime = 0
    add(self.particles, particle)
    nb -= 1
  end
end