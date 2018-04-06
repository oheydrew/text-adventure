class Engine

  attr_reader :world, :player

  def initialize(worldsize, playername)

    @world = create_world(worldsize)
    @player = create_player(playername)

  end

  def start
    main_loop
  end

  def main_loop

    # big ugly proof of concept loop:
    # break into parts:
    # interface will take input, strip, split words into array
    # interface will iterate through array to determine player decision

    # turn-based system will eventually arrive, for player and monster actions
    # ideally, when this is implemented, a 'main loop' may not be necessary

    loop do 
      command = input_prompt('What would you like to do?')
      case command
      when 'move', 'm'
        direction = input_prompt('Which direction would you like to move in?')
        player.move(@world, direction)
      when 'look', 'l'
        puts "** Engine: #{player.look(where_is_player)}"
        puts ''
      when 'quit', 'q', 'exit', 'x'
        response = input_prompt('Are you sure you want to exit?')
        case response
        when 'yes', 'y'
          exit
        end
      else
        puts 'I\'m quite sure I don\'t understand.'
      end
    
      puts "You stand in a #{player.location(world).descriptor}, #{player.location(world).description}"
      puts ''
    end
  end

  
  def where_is_player()
    found_location = nil
    @world.each do |x|
      x.each do |y|
        found_location = y if y.player_present == true
      end
    end
    found_location
  end
  
  private
  
  # World generation
  def create_world(size)
    # generates an Array(x) of Arrays(y) (the map)
    Array.new(size) { |x| Array.new(size) { |y| Location.new([x, y])} }
  end
  
  # Player creation
  
  def create_player(playername)
    player = Entity.new([@world.size / 2, @world.size / 2], 'player', playername ,100 ,'axe' ,'cherry pie')
    @world[player.coordinates[0]][player.coordinates[1]].player_present = true
    return player
  end

end



# # Testing some location stuff
# test = Location.new([1,3])

# puts 'The ' + test.name.split(' ').map(&:capitalize).join(' ')
# puts 'You stand in a ' + test.description
# puts 'A ' + test.barrier + ' blocks your path. You can\'t go this way.' 
# puts ''

# # Testing world stuff
# world = World.new(5)
# world.show

# # Testing some player stuff
# player = Entity.new(world, 'player', 'Drew' ,100 ,'axe' ,'cherry pie')

# puts player.look(player.location)
# player.move('n')
# puts player.look(player.location) # problems with move
# player.move('n')
# player.move('n')
# player.move('e')
# puts player.look(player.location)
# player.move('east')
# puts ''

# puts 'testing look function'
# puts player.look(player.location)