Gui = {}
Gui.__index = Gui

function Gui:new()
  local instance = setmetatable({}, Gui)

  instance.gui_x = 0
  instance.gui_y = 0

  return instance
end

function Gui:update(object)
  self.gui_x = object.x - 64
  self.gui_y = object.y - 64
end

function Gui:draw()
  rectfill(self.gui_x - 5, self.gui_y - 5, self.gui_x + 132, self.gui_y + 9, 1)

  --PV
  print("life: " .. player.pv, self.gui_x + 2, self.gui_y + 1, 2)
  print("life: " .. player.pv, self.gui_x + 2, self.gui_y + 3, 2)
  print("life: " .. player.pv, self.gui_x + 1, self.gui_y + 2, 2)
  print("life: " .. player.pv, self.gui_x + 3, self.gui_y + 2, 2)

  print("life: " .. player.pv, self.gui_x + 2, self.gui_y + 2, 9)

  --score

  print("score: " .. player.score, self.gui_x + 42, self.gui_y + 1, 2)
  print("score: " .. player.score, self.gui_x + 42, self.gui_y + 3, 2)
  print("score: " .. player.score, self.gui_x + 41, self.gui_y + 2, 2)
  print("score: " .. player.score, self.gui_x + 43, self.gui_y + 2, 2)

  print("score: " .. player.score, self.gui_x + 42, self.gui_y + 2, 9)
end