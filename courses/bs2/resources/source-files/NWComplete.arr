import image as I
import world as W

data World:
    # The world is the x and y positions of the dog, the x position of the ruby, the y position of the cat, and the player's score.
  | world(dogX :: Number, dogY :: Number, rubyX :: Number,
      catY :: Number, score :: Number)
end

START = world(0, 400, 600, 240, 0)
NEXT = world(10, 400, 595, 240, 0)

BACKGROUND = I.image-url(
  "http://www.bootstrapworld.org/clipart/Curriculum/bg.jpg")
BACKGROUND2 = I.image-url(
  "http://www.bootstrapworld.org/clipart/Curriculum/bg2.jpg")
DANGER = I.image-url(
  "http://www.bootstrapworld.org/clipart/Curriculum/dog.png")
TARGET = I.scale(0.3, I.image-url(
  "http://www.bootstrapworld.org/clipart/Curriculum/ruby.png"))
PLAYER = I.image-url(
  "http://www.bootstrapworld.org/clipart/Curriculum/ninja.png")
CLOUD = I.image-url(
  "http://www.bootstrapworld.org/clipart/Curriculum/clouds.png")

####################
# GRAPHICS FUNCTIONS
####################

fun draw-world(w :: World) -> I.Image:
  doc: "Place DANGER, TARGET, CLOUD, PLAYER, and SCORE onto BACKGROUND at the right coordinates."
  if w.score > 500:
    I.put-image(I.text(num-tostring(w.score), 30, "white"), 320, 440,
      I.put-image(PLAYER, 320, w.catY,
        I.put-image(TARGET, w.rubyX, 300,
          I.put-image(CLOUD, 500, 400,
            I.put-image(DANGER, w.dogX, w.dogY, BACKGROUND)))))
  else:
    I.put-image(I.text(num-tostring(w.score), 30, "white"), 320, 440,
      I.put-image(PLAYER, 320, w.catY,
        I.put-image(TARGET, w.rubyX, 300,
          I.put-image(CLOUD, 500, 400,
            I.put-image(DANGER, w.dogX, w.dogY, BACKGROUND)))))
  end
end

####################
# UPDATING FUNCTIONS
####################

fun update-world(w :: World) -> World:
  doc: "Increase dogX by ten, decrease rubyX by five."
  ask:
    | is-collide(320, w.catY, w.dogX, w.dogY) then:
      world(-50, num-random(480), w.rubyX, w.catY, w.score - 20)
    | is-collide(320, w.catY, w.rubyX, 300) then:
      world(w.dogX, w.dogY, 650, w.catY, w.score + 30)
    | is-off-left(w.rubyX) then:
      world(w.dogX, w.dogY, 700, w.catY, w.score)
    | is-off-right(w.dogX) then:
      world(-100, num-random(480), w.rubyX, w.catY, w.score)
    | otherwise:
      world(w.dogX + 10, w.dogY, w.rubyX - 5, w.catY, w.score)
  end
end

#############
# KEY EVENTS:
#############

fun keypress(w :: World, s :: String) -> World:
  doc: "Make catY respond to key events."
  ask:
    | strings-equal(s, "up") then:
      world(w.dogX, w.dogY, w.rubyX, w.catY + 10, w.score)
    | strings-equal(s, "down") then:
      world(w.dogX, w.dogY, w.rubyX, w.catY - 10, w.score)
    | otherwise: world(w.dogX, w.dogY, w.rubyX, w.catY, w.score)
  end
end
  
#################
# TESTS FOR COND:
#################

fun is-off-left(x :: Number) -> Boolean:
  doc: "Checks whether an object has gone off the left side of the screen."
  x < 0
end

fun is-off-right(x :: Number) -> Boolean:
  doc: "Checks whether an object has gone off the right side of the screen."
  x > 640
end

fun line-length(x1 :: Number, x2 :: Number) -> Number:
  doc: "Finds 1D distance."
  if x1 < x2:
    x2 - x1
  else:
    x1 - x2
  end
end

fun distance(x1 :: Number, y1 :: Number, x2 :: Number,
    y2 :: Number) -> Number:
  doc: "Finds 2D distance between (x1, y1) and (x2, y2)."
  num-sqrt(num-sqr(line-length(x1, x2)) + num-sqr(line-length(y1, y2)))
end

fun is-collide(x1 :: Number, y1 :: Number, x2 :: Number,
    y2 :: Number) -> Boolean:
  doc: "Determines whether two objects are within 50 pixels of each other."
  distance(x1, y1, x2, y2) < 50
end

###################################
# big-bang using the START world
# on a tick-event, use update-world
# on a draw-event, use draw-world 
# on a key-event, use keypress
###################################

W.big-bang(START, [list:
  W.on-tick(update-world),
  W.to-draw(draw-world),
    W.on-key(keypress)])