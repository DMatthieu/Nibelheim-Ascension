function game_init()
  width, height = 128, 128

  game_map = Game_map:new()
  player = Player:new()
  gui = Gui:new(player.x, player.y)
end

function game_update()
  player:update()
  player:animate()

  game_map:update()
  gui:update(player)
end

function game_draw()
  game_map:draw()
  player:draw()
  gui:draw()
end