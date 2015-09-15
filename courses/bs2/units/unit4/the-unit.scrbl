#lang curr/lib

@title{Unit 4: Welcome to the World}
@declare-tags[]

@unit-overview/auto[#:lang-table (list (list "Number" @code{+ - * / num-sqr num-sqrt num-expt})
                                       (list "String" @code{string-append string-length})
                                       (list "Image"  @code{rectangle circle triangle ellipse star text scale rotate put-image})
                                       (list "Car" @code{car .model .hp .rims .color .price})
                                       (list "Party" @code{party .theme .location .guests}))]{
@unit-descr{Students are introduced to the Ninja World game, and codewalk through the ’update-world’ and ’draw-world’ functions. 
            Making minimal changes to these functions, they are able to modify the dog’s speed and add static clouds. They then 
            modify the World to include the target’s x-coordinate, and systematically update each function in the source code to 
            accommodate this new World. If time allows, additional iterations are possible by adding more sets of coordinates to 
            the World. Students brainstorm their videogames, and derive the structure for their game World.}
}
@unit-lessons{
@lesson/studteach[#:title "Review: Autobody Shop"
        #:duration "10 minutes"
        #:overview ""
        #:learning-objectives @itemlist[]
        #:evidence-statements @itemlist[]
        #:product-outcomes @itemlist[]
        #:standards (list)
        #:materials @itemlist[@item{Pens/pencils for the students, fresh whiteboard markers for teachers}
                            @item{Class poster (List of rules, design recipe, course calendar)}
                            @item{Editing environment (Pyret Editor)}
                            @item{Language Table}]
        #:preparation @itemlist[@item{The @editor-link[#:public-id "0B9rKDmABYlJVSlI4VEZLLUI4UkU" "Autobody Shop"] file used in the previous unit, preloaded on students' machines}
                                 @item{Seating arrangements: ideally clusters of desks/tables}]
     #:pacings (list 
                @pacing[#:type "remediation"]{@itemlist[@item{}]}
                @pacing[#:type "misconception"]{@itemlist[@item{}]}
                @pacing[#:type "challenge"]{@itemlist[@item{}]}
                )
      ]{
        @points[@point{@student{In our autobody shop we’ve been working with pretty basic cars. They have a model, horsepower, a rim size, color, and price.
                                @activity{What datatype do we use for each of these things?}
                                What if we realize later, after defining our Car struct, that it would be helpful to include more information about each car, like whether or not it 
                                has a sunroof? Thankfully, working in Pyret it’s easy to change our data definition so a car can include this as well.
                                @activity{@itemlist[@item{How would you change the data definition to include this new information about cars?}
                                                     @item{What new argument does the @code{car} function need to take in? What kind of data is this?}
                                                     @item{Change your Car definition that begins on line 4 of the @editor-link[#:public-id "0B9rKDmABYlJVSlI4VEZLLUI4UkU" "Autobody Shop"] file so it includes this new information.}]}
                                Important! When you change @italic{any} data structure, @bold{all} @vocab{instances} of that structure will need to change as well. 
                                Right now our definitions for @code{car1}, @code{car2}, and @code{car3} are creating cars with only five inputs--- we need to 
                                add the information about the sunroof!

@activity{Change the definitions of @code{car1}, @code{car2}, @code{car3} and the other cars you defined so they reflect the new Car struct. }}
                        @teacher{}}
                 ]
         }
@lesson/studteach[#:title "Codewalking"
        #:duration "40 minutes"
        #:overview ""
        #:learning-objectives @itemlist[@item{Deepen their understanding of structures, constructors and accessors by being introduced to a third data structure.}
                                        @item{Discover the event-based microworld implementation of Pyret, which uses events to modify the World.}]
        #:evidence-statements @itemlist[]
        #:product-outcomes @itemlist[]
        #:standards (list)
        #:materials @itemlist[]
        #:preparation @itemlist[@item{The @editor-link[#:public-id "0B9rKDmABYlJVNk9oT0dvVWdTMGs" "Ninja World 1"] file preloaded on students' machines}
                                 @item{update-world, big-bang, and draw-world nametags}
                                @item{cutout image of dog}]
        #:pacings (list 
                @pacing[#:type "remediation"]{@itemlist[@item{}]}
                @pacing[#:type "misconception"]{@itemlist[@item{}]}
                @pacing[#:type "challenge"]{@itemlist[@item{}]}
                )
      ]{
        @points[@point{@student{Do you remember the Ninja Cat game from Bootstrap:1? In this course, you're going to completely deconstruct the game and  make it much more interesting, using data structures to manage additional information about the various game elements. The data structure we'll be using in these activities will be a World, representing all the relevant information in the game. To start, we'll use a World that only contains one number, representing the x-coordinate of the dog.
                                @activity{Open the @editor-link[#:public-id "0B9rKDmABYlJVNk9oT0dvVWdTMGs" "Ninja World 1"] file and press "Run". 
                                                   @itemlist[@item{What do you see in the game window? How many things are changing?}
                                                              @item{Go back to the code and look at the line where the @code{World} data structure is defined.}
                                                              @item{What is the name of this data structure?}
                                                              @item{The @code{World} is made up of just one thing: @code{dogX}. What does @code{dogX} represent in the game? What type of data is that?}
                                                              @item{Take a look at the section labelled @code{# STARTING WORLD}. There is a variable defined here, called 
                                                                    @code{START}. What kind of a thing is @code{START}? A Number? String? Image? Boolean?}
                                                              @item{What function creates a World?}
                                                              @item{There are several image variables defined below. What are they images of? Type their names into the interactions area to find out.}]}
                                {@activity{Scroll a little farther down to where you see @code{# GRAPHICS FUNCTIONS}. 
                                                                      @itemlist[@item{What is the name of the function defined here?}
                                                                                 @item{What is the Domain of this function? The Range?}
                                                                                 @item{According to the purpose statement, what does this function do?}]}
                                 Now look at the body of @code{draw-world}. It's using a function you might remember from Bootstrap 1, called @code{put-image}, which takes
                                 in an image, and then places it on top of another image, using the x- and y-coordinates to determine where to put it. In this example, it 
                                 is placing the @code{DOG} onto the @code{BACKGROUND}. @activity{What is it using for the dog's x-coordinate? The dog's y-coordinate?}}
                                
                                @activity{@itemlist[@item{Scroll a bit farther down to where it says @code{# UPDATING FUNCTIONS}. What is the name of the function 
                                                                    defined here? What's its domain and range?}
                                                              @item{Think about what the @code{update-world} function is doing. How does it get the @code{dogX} out of the
                                                                    World? What is it doing to the dog's x-coordinate? How will this make the dog move? Does it go to the right, left, up, or down?}
                                                              @item{If the dog is at 100, where will it be next? After that?}
                                                              @item{How could you make the dog move faster? Slower? Backwards?}]}
                                Every time @code{update-world} runs, it creates a World where the @code{dogX} of the original World increases by 10.}
                                
                        @teacher{These activities encourage students to read others' code and think about how it works, looking at the contracts and definitions and 
                                 piecing together what they already know. Ask a LOT of questions when going through the file: How do we know we need to make a new 
                                 World in @code{update-world}? (Because the range is a World). Why is @code{dogX} a good variable name? Ask them to
                                 guess what they think expressions like @code{update-world(START)} will do in the game.}}
                 
                 @point{@student{@activity{Now skip down to the last function defined in our code: @code{big-bang}. This is a special function that will begin an animation, 
                                          but it needs help from other functions to update and draw the World. 
                                          @itemlist[@item{Which World is @code{big-bang} taking in?}
                                                     @item{In the code, @code{big-bang} is calling on a few different functions. What new functions can you see used in 
                                                                        @code{big-bang}?}]}
                                  The function @code{on-tick} acts kind of like a timer, and on each "tick", it updates the World. Right now the World struct is 
                                  just one number, representing the x-coordinate of the dog. @code{on-tick(update-world)} tells the computer to update 
                                  the World on every tick.
                                 @activity{@itemlist[@item{How does it do that? Think back to what @code{update-world} does to the @code{dogX} of the World.}]}
                                 @code{on-tick(update-world)} tells the computer how to update the World structure, but this wouldn't be much of a game without images! We need to know how to @italic{draw} the World, too.}
                         @teacher{Each of these three functions work together to create the game that students see. @code{data World:} and @code{world(...)} tells the 
                                  computer what a World contains, @code{draw-world} draws the images onto the screen, and @code{update-world} changes the 
                                  World, according to the rules of the game. Point out to students that without all of these functions, the game would not be 
                                  playable.
                                  Once students understand the purpose of these functions, they need to understand how they work together. Have volunteers act out 
                                  @code{update-world} and @code{big-bang}, giving them nametags with the function names on them and having them come to the board.
                                  Have them explain to the class what their contracts are and what they do. Write: "World" on the board, with the number @code{0} beneath it. 
                                  When you yell "@code{big bang(0)}", have the class start counting time, yelling "tick!" every five seconds. On every tick, @code{big-bang} 
                                  must call on @code{update-world} to update the World written on the board. This results in the number changing over time, starting with 0.
                                  
                                  Then have another volunteer be @code{draw-world}, giving them the "draw-world" nametag and the dog cutout. Draw a large 
                                  rectangle on the board, representing the screen. Now have big-bang call both @code{update-world} and @code{draw-world} on each "tick", 
                                  causing the number on the board to increase and the dog to move across the screen a little each time. Have the class go through a few 
                                  iterations of this. By acting out these steps, students are demonstrating exactly how the three functions work together in the code to 
                                  complete the computer animation.}}
                 ]
         }
@lesson/studteach[#:title "Extending the World"
        #:duration "15 minutes"
        #:overview ""
        #:learning-objectives @itemlist[@item{Students will modify @code{draw-world} to add clouds and a coin}
                                         @item{Students will iteratively expand the World structure, and trace these changes throughout their program}]
        #:evidence-statements @itemlist[]
        #:product-outcomes @itemlist[]
        #:standards (list)
        #:materials @itemlist[]
        #:preparation @itemlist[]
        #:pacings (list 
                @pacing[#:type "remediation"]{@itemlist[@item{}]}
                @pacing[#:type "misconception"]{@itemlist[@item{}]}
                @pacing[#:type "challenge"]{@itemlist[@item{}]}
                )
      ]{
        @points[@point{@student{Suppose you want to add the image of the @code{CLOUD} to the game at the position (500, 400). If the cloud stays at the same poition and doesn't move, which function should we change? @code{draw-world}, @code{update-world}, or both? If nothing changes about the cloud or its position, we just need to add the image to the @code{draw-world} function. We don't even need to add anything to the World structure, because the World should contain only what is @italic{changing}. We don't need to update or animate something that isn't changing, but in this case we just want to see a static picture of it in the world!
                                                                         
                                 @activity{How could you use @code{put-image} to place the image of the CLOUD onto the @code{BACKGROUND-IMG} at position (500, 400)?}
                                 
@code[#:multi-line #t]{
# draw-world:  World -> Image
# Place DOG-IMG and CLOUD-IMG onto BACKGROUND-IMG at the right coordinates
fun draw-world(current-world): 
  put-image(CLOUD-IMG, 
    500, 400,
    put-image(DOG-IMG, 
      current-world.dogX, 400, 
      BACKGROUND-IMG))
end}
@bitmap{images/NWorld2.png}
}                                                   
                         @teacher{Since this is their first time using @code{put-image} themselves, write the code with the kids. They'll have 
                                  time to practice on their own later. Point out the "staircase" pattern that develops when you put images on
                                  top of one another. Once they've put the image onto the background, have them click "Run" and 
                                  take a look at that cloud!}}
                 
                 @point{@student{Now let's make Ninja World a little more exciting: 
                                @activity{If you wanted to add the @code{COIN-IMG} into the World, making it move across the screen slowly at 5 pixels each frame, what will you need to modify?}
                                Since the coin is moving, and its position changing, we'll need to keep track of its position in the World structure. 
                                 @activity{@itemlist[@item{What specifically will be changing about the coin?}
                                                      @item{If the coin @italic{only} moves to the left, will we need to add its x-coordinate, y-coordinate, or both to the World structure?}
                                                      @item{How does the World struct need to change?}
                                                      @item{What is a good variable name to represent the coin's x-coordinate? How about @code{coinX}?}
                                                      @item{How has the contract for @code{world} changed? Update it in the comment for the World structure!}
                                                      @item{Now that the World structure includes a @code{coinX}, What new dot-accessor do you have access to?}]}
                                 The new dot-accessor is @code{.coinX}, so you can write @code{current-world.coinX} to pull the coin's x-coordinate out of a World @code{w}.}
                         @teacher{}}
                 
                 @point{@student{Because we have changed the World structure, we need to go through the code, line-by-line, and change every
                                 World we find. Look at the @code{START} variable - It uses the @code{world} function, which now requires 
                                 @italic{two} inputs in its Domain. 
                                 @activity{@itemlist[@item{What should the coin's x-coordinate be when the game starts? Include this number in the @code{START} World.}
                                                      @item{Do the definitions of the image variables need to change? Why not?}
                                                      @item{What about @code{draw-world}? Does its contract change? The contract says it 
                                                            takes a World as its Domain, and it still does. The only thing that has changed 
                                                            is @italic{what a World contains}. Does @code{draw-world} still produce an Image?}
                                                      @item{What needs to change about the body of @code{draw-world}?}
                                                      @item{How could you use @code{put-image} to add the image of the COIN-IMG to the World? At which coordinates should it be placed?}
                                                      @item{For now, let's say that the y-coordinate of the coin will always be 300. But what about the x-coordinate? It's always changing, so we'll need to access it from the World structure.}
                                                      @item{How do you get the @code{coinX} out of the World? Place the
                                                            COIN-IMG at that x-coordinate.}]}
@code[#:multi-line #t]{
# draw-world : World -> Image
# Place DOG-IMG, CLOUD-IMG and COIN-IMG onto BACKGROUND-IMG at the right coordinates
 fun draw-world(current-world):
    put-image(COIN-IMG, current-world.coinX, 300,
        put-image(CLOUD-IMG, 500, 400,
            put-image(DOG-IMG, current-world.dogX, 200, BACKGROUND-IMG)))
end}}
                         @teacher{For this section, you can write the code on the board or use a projector to show the
                                 code, and use cutouts of the dog and coin to model their behavior, while students follow along on their computers.}}
                 
                 @point{@student{What about the @code{update-world} function? Does its contract change, now that the World structure is different? Why or why 
                                 not? @activity{Open your workbook to @worksheet-link[#:page 16 #:name "Update-world"], and copy down the contract.}
                                 Once again, the contract tells you a LOT about how to write the function. Here's a quick tip: if the range is a World, you know that you'll have to create a World at some point. @activity{How do you make a World?}}
                         @teacher{}}
                 @point{@student{The moment you write @code{world}, your instincts should kick in right away: Every World contains a @code{dogX}
                                 and a @code{coinX}, so you can write them down automatically, then think about @italic{how} they change:
                                 @code{world(....dogX..., ...coinX...)}
                                 
                                 Now you can ask yourself: What happens to @code{dogX}? In the game, the dog will still be moving to the right by 
                                 10 pixels, but the coin will be moving to the left by 5 pixels. 
                                 @activity{@itemlist[@item{Start by writing two examples for @code{update-world}. For the first, what will happen if you call @code{update-world} on START?}
                                                      @item{How will you update the x-position of the dog? How do you get the @code{dogX} out of the World?}
                                                      @item{How would you add ten to that?}
                                                      @item{We said we wanted the coin to move to the left by 5 pixels. How do you get the @code{coinX} 
                                                            out of the World?}
                                                      @item{If it's moving to the left, will you add or subtract from the position?}
                                                      @item{Which World are you pulling the @code{dogX} and @code{coinX} out of?}]}
                                 
                     @code[#:multi-line #t]{examples:
                                               update-world(START) is world(START.dogX + 10, START.coinX + 5)
                                            end
                                 }
                                 @activity{In the second example, start with a world that isn't pre-defined. For instance, what will happen if you call @code{update-world} on @code{world(100, 545)}?}
                                 
                 @code[#:multi-line #t]{examples:
                                           update-world(START) is world(START.dogX + 10, START.coinX + 5)
                                           update-world(world(100, 545)) is world(100 + 10, 545 - 5)
                                        end
                                 }
                                            
                                 @activity{Complete the Design Recipe for @code{update-world}, and type it into Ninja World!}}          
                         @teacher{Every time the World (or @italic{any} structure) changes, every single instance of @code{world} (or @code{car},
                                  @code{party}, etc.) will need to change to reflect that. Have students find instances of @code{world} and 
                                  incorporate @code{coinX} into the new World. Any time they add something new to their game they will need to do 
                                  the same thing, so make sure they understand that every change to the World structure requires careful reading 
                                  and editing of their World functions.}}
                         ]
         }

@lesson/studteach[#:title "Game Brainstorming"
        #:duration "20 minutes"
        #:overview ""
        #:learning-objectives @itemlist[]
        #:evidence-statements @itemlist[]
        #:product-outcomes @itemlist[@item{Students will define their World structures}]
        #:standards (list)
        #:materials @itemlist[]
        #:preparation @itemlist[]
        #:pacings (list 
                @pacing[#:type "remediation"]{@itemlist[@item{}]}
                @pacing[#:type "misconception"]{@itemlist[@item{}]}
                @pacing[#:type "challenge"]{@itemlist[@item{}]}
                )
      ]{
        @points[@point{@student{@activity{Suppose I have a racing game, where my player is at the bottom of the screen, sitting in their car. In front 
                                          of them, I have two lanes, with cars coming at me as I catch up to them. To move out of the way, I need to 
                                          change into the left or right lane of the road. 
                                          @itemlist[@item{What are all the things I need to keep track of in my game?}
                                                     @item{@code{PlayerX} - a number}
                                                     @item{@code{CarY} - a number}
                                                     @item{@code{Car2Y} (if I want another car) - a number}
                                                     @item{@code{Score} - a number}
                                                     @item{How would I define this World structure?}
                                                     @item{How do I get the @code{playerX} out of my word? My @code{CarY}? My @code{Car2Y}? The score?}
                                                     @item{What if I wanted the player's car to change color as the score goes up? How would my World 
                                                           structure need to change?}]}
For the last three lessons you have been working with structures, and have gotten really good at defining, making and accessing them. Now, it's time to think about YOUR game--- what will be changing in @italic{your} World structure?}
                                                                                
                  @teacher{Make sure students collaborate with their partner(s) to brainstorm a game that they will both be happy with. Make sure 
                           you force them to think about their World structures, and start simple: Limit their World structure to no more than five things, initially.}}
                 
                 @point{@student{@activity{@itemlist[@item{Turn to @worksheet-link[#:page 17 #:name "Game Design 1"] in your workbooks. First, you're going to draw two rough sketches: In the box on the left side of the page, draw a sketch of what your game should look like at the @italic{very start}, when the user clicks "Run". In the box on the right, draw a sketch of the game at the very next moment- what has changed?}
                                                     @item{Keep your game simple at first! You can always add more things to make it more complex later on, but start with just @bold{five or fewer} game elements to begin with.}
                                                     @item{On the left side of the table directly underneath your sketches, list all the images you'll need for your game. We've gotten you started by listing the background. On the right side, describe the image- what does the background look like? What does your player look like?}
                                                     @item{Now, in the last table on @worksheet-link[#:page 17 #:name "Game Design 1"], make a list of everything that changes in your game @italic{from the very first second to the next}. What changed in the second sketch you drew?}
                                                     @item{After listing what changed on the left side of the table, write what data type you would use to describe that thing on the right side: if something moves, will you need to keep track of it's x-coordinate? y? both?}]}}
                        @teacher{}}

                 @point{@student{Now that you've gotten a list of everything that changes, it's time to turn them into a World structure.
            @activity{@itemlist[@item{Turn to @worksheet-link[#:page 18 #:name "Game Design 2"] in your workbooks, and define your World structure, using your list from the previous page about what changes in your game.}
                                 @item{When you have your World structure, write down the contract for the @code{world} constructor, and two example Worlds called START and NEXT: START should be the state of your game world right when the game begins, and NEXT should show the game world a split-second @italic{after} the start of the game. Lok at your sketches on the previous page for help!}
                                 @item{Finally, make a list of all the dot-accessors you'll have access to once you've defined the World structure.}]}}
                        @teacher{Many students will want to create ambitious games at first, with many values in their World structure. Make sure they start
                                 simple at first: Once they have a simple game working, they can add more elements and features to make it more advanced.
                                 Check their work: Does each pair's World structure correspond to the things that are changing in their game? Review each team's structure and make sure it accurately models their World. Also be sure to check their 
                                 @code{world} contract and dot-accessors.}}
                 ]
         }
@lesson/studteach[#:title "Closing"
        #:duration "5 minutes"
        #:overview ""
        #:learning-objectives @itemlist[]
        #:evidence-statements @itemlist[]
        #:product-outcomes @itemlist[]
        #:standards (list)
        #:materials @itemlist[]
        #:preparation @itemlist[]
        #:pacings (list 
                @pacing[#:type "remediation"]{@itemlist[@item{}]}
                @pacing[#:type "misconception"]{@itemlist[@item{}]}
                @pacing[#:type "challenge"]{@itemlist[@item{}]}
                )
      ]{
        @points[@point{@student{Now you have the basic building blocks of your game and an understanding of how @code{draw-world}, 
                               @code{update-world}, and @code{big-bang} work together to create an animation in Pyret. In the next unit you'll
                               use your World structure to write the @code{draw-world} and @code{update-world} functions for your own game.}
                       @teacher{Have the class take turns telling their peers about their games: Who the player is, what their danger, target, etc. 
                                will be. Most importantly, have them tell the class what they have in their World structure.
@itemlist[@item{Make sure student names are on page 17}
                   @item{Take page 17 itself, or take photos of page 17, to prep game images for the next unit.}
                   @item{Images should be in PNG or GIF format. Background images should be 640x480, and character images should generally be 
                         no larger than 200px in either dimension. Make sure that the character images have transparent backgrounds!}
                   @item{TIP: use animated GIFs for the characters - not only does the animation make the game look a lot better, but these 
                         images usually have transparent backgrounds to begin with.}]}
                       }
                 ]
         }
       }