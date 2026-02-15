

function game_init()
  width, height = 128, 128
  
  game_map = Game_map:new()
  player = Player:new()
end

function game_update()
  player:update()
  player:animate()

  --camera
  
  
end

function game_draw()
  game_map:draw()
  player:draw()
end