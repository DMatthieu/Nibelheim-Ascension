function game_over_init()
end

function game_over_update()
  if btnp(5) then
    run()
  end
end

function game_over_draw()
  camera(0, 0)
  print("you died...", 40, 55, 2)
  print("you died...", 40, 57, 2)
  print("you died...", 39, 56, 2)
  print("you died...", 41, 56, 2)
  print("you died...", 40, 56, 8)
end