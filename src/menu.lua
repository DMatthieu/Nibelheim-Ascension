function menu_init()
  title = "nibelheim ascension"
end

function menu_update()
  if btnp(5) then scene = "game" end
end

function menu_draw()
  print(title, 10, 10, 7)
  print("press x to play", 10, 20, 10)
end