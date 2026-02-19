function game_over_init()
end

function game_over_update()
  if btnp(5) then
    run()
  end
end

function game_over_draw()
  camera(0, 0)
  print("you died", 10, 10, 8)
  printh(scene)
end