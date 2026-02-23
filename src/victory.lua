function victory_init()
end

function victory_update()
  if btnp(5) then
    run()
  end
end

function victory_draw()
  camera(0, 0)
  print("victory", 40, 55, 3)
  print("victory", 40, 57, 3)
  print("victory", 39, 56, 3)
  print("victory", 41, 56, 3)
  print("victory", 40, 56, 11)
end