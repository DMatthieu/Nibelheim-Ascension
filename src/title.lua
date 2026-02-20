title = {}

function title_init()
  title.t = 0
  title.sel = 1
  title.items = { "start", "story (wip)" }
  title.blink = 0
end

function title_update()
  title.t += 1
  title.blink = (title.t \ 15) % 2

  -- navigation menu
  if btnp(2) then title.sel = max(1, title.sel - 1) end
  -- up
  if btnp(3) then title.sel = min(#title.items, title.sel + 1) end
  -- down

  -- validate
  if btnp(4) then
    -- X
    local choice = title.items[title.sel]
    if choice == "start" then
      scene = "game"
    elseif choice == "credits" then
      -- TODO: change state to credits
      -- scene = "story"
    end
  end
end

-- fond "médiéval" simple : ciel + silhouettes + torches
function title_draw()
  cls()

  -- titre (ombre + petit flottement)
  local bob = sin(title.t / 90) * 1.5
  line(0, 0, 127, 0, 1)
  line(127, 0, 127, 127, 1)
  line(127, 127, 0, 127, 1)
  line(0, 127, 0, 0, 1)
  shadow_print("nibelheim ascension", 28, 17 + bob, 8, 0)
  shadow_print("nibelheim ascension", 28, 19 + bob, 8, 0)
  shadow_print("nibelheim ascension", 27, 18 + bob, 8, 0)
  shadow_print("nibelheim ascension", 29, 18 + bob, 8, 0)
  shadow_print("nibelheim ascension", 28, 18 + bob, 7, 0)
  shadow_print("gamecodeur community", 25, 30, 6, 0)
  shadow_print("gamejam #2", 43, 39, 6, 0)
  shadow_print("v0.0.7", 51, 120, 6, 0)

  -- menu
  local my = 78
  for i = 1, #title.items do
    local it = title.items[i]
    local y = my + (i - 1) * 10
    if i == title.sel then
      -- curseur
      shadow_print("▶ " .. it, 42, y, 7, 0)
    else
      shadow_print("  " .. it, 44, y, 6, 0)
    end
  end

  -- hint
  if title.blink == 0 then
    shadow_print("press c...", 44, 110, 5, 0)
  end
end

-- imprimer avec ombre
function shadow_print(str, x, y, col, scol)
  scol = scol or 0
  print(str, x + 1, y + 1, scol)
  print(str, x, y, col)
end