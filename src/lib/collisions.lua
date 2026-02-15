
--Platformer mechanics and code are originally from
--Nerdy Teachers.com
--small adjustments and additions by T713
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
    x2 = x + w -1
    y2 = y
  elseif aim == "down" then
    x1 = x + 2
    y1 = y + h
    x2 = x + w - 2
    y2 = y + h
  end

  -- pixels to tiles
  x1 /= 8
  y1 /= 8
  x2 /= 8
  y2 /= 8

  if fget(mget(x1, y1), flag_number)
  or fget(mget(x1, y2), flag_number)
  or fget(mget(x2, y1), flag_number)
  or fget(mget(x2, y2), flag_number)then
    return true
  else
    return false
  end
end