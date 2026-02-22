function story_init()
  story = "cast into the depths of hell, \na nameless knight awakens among \nash and embers.\nin life, he was no legend \n- no dragon-slayer, no crowned \nhero - only a soldier lost \nin the ranks of greater men. \n\nyet one tale clung to his name: \nhe could climb ladders faster \nthan his own shadow.\nnow, in the underworld's\nendless abyss, a single\npath rises above the flames \n- the Tower of Nibelheim.\neach rung leads closer to\nthe world of the living, but\nthe damned claw at his heels\nand infernal wardens guard \nevery ascent.\nhe was never destined for \ngreatness. but perhaps in Hell, \nspeed is enough to \noutrun fate?...\n\n press c to go back..."
  txt_y = 2
  offset = 4
end

function story_update()
  if btnp(4) then
    scene = "title"
  end
  if btnp(3) and (txt_y > -40) then
    txt_y -= offset
  elseif btnp(2) and (txt_y < 6) then
    txt_y += offset
  end
end

function story_draw()
  print(story, 2, txt_y, 7)
  printh(txt_y)
end