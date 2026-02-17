--Platformer mechanics and code are originally from
--Nerdy Teachers.com
--small adjustments and additions by Matt
function collide_map(object, aim, flag_number)
  -- object = table (x, y, w, h)
  local x = object.x
  local y = object.y
  local w = object.w
  local h = object.h

  local x1 = 0
  local x2 = 0
  local y1 = 0
  local y2 = 0

  if aim == "left" then
    x1 = x - 1
    y1 = y
    x2 = x
    y2 = y + h - 1
  elseif aim == "right" then
    x1 = x + w
    y1 = y
    x2 = x + w + 1
    y2 = y + h - 1
  elseif aim == "up" then
    x1 = x + 1
    y1 = y - 1
    x2 = x + w - 1
    y2 = y
  elseif aim == "down" then
    x1 = x + 2
    y1 = y + h
    x2 = x + w - 2
    y2 = y + h
  elseif aim == "center" then
    x1 = x + 3
    y1 = y + 3
    x2 = x + 5
    y2 = y + 5
  end

  -- pixels to tiles
  x1 /= 8
  y1 /= 8
  x2 /= 8
  y2 /= 8

  if fget(mget(x1, y1), flag_number)
      or fget(mget(x1, y2), flag_number)
      or fget(mget(x2, y1), flag_number)
      or fget(mget(x2, y2), flag_number) then
    return true
  else
    return false
  end
end

function sphere_collide_sphere(obj1, obj2)
  local x1 = obj1.x
  local y1 = obj1.y
  -- local w1 = obj1.w
  -- local h1 = obj1.h
  local r1 = obj1.agro_radius

  local x2 = obj2.x
  local y2 = obj2.y
  -- local w2 = obj2.w
  -- local h2 = obj2.h
  local r2 = obj2.agro_radius

  return (abs(x1 - x2) <= (r1 + r2))
end

function spr_object_collide_spr_object(obj1, obj2)
  local x1 = obj1.x
  local y1 = obj1.y
  -- local w1 = obj1.w
  -- local h1 = obj1.h
  local w1 = obj1.w

  local x2 = obj2.x
  local y2 = obj2.y
  -- local w2 = obj2.w
  -- local h2 = obj2.h
  local w2 = obj2.w

  return (abs(x1 - x2) <= 16)
end