# This file contains all human input and interface logic. It will likely be
# extended into a class, or perhaps two, one may be an output/display class

def input_prompt(prompt)
  print "#{prompt} : ".colorize(:light_blue)
  input = gets.strip.downcase
  puts ''
  return input
end

def get_command(input)
  input = input.split(/\W+/).push('')
  input -= %w[up to at in the]
  { command: input[0],
    target: input[1] }
end

def execute_command(command)
  # big ugly loop. TODO: break into parts:
  # interface will take input, strip, split words into array
  # execute_command will iterate through array to determine player decision
  # execute_command will pass off targets of commands to relevant functions
  # (this is demonstrated in player.move - but may need to be abstracted further)

  case command[:command]
  when 'look', 'l'
    engine_msg(self, player.location_in(world).full_name.to_s)
    player.look_at(player.location_in(world))
  when 'move', 'm', 'walk', 'w'
    case command[:target].to_sym
    when *COMPASS.keys # '*' breaks out a hash and checks for each
      player.move(world, command[:target])
    else
      puts "...That's not a direction. Try N S E W.".colorize(:light_red)
      puts ''
    end
  when 'pick', 'p', 'get', 'g', 'take', 't' 
    engine_msg(self, 'pick_up method not yet implemented')
    # pick_up
  when 'use', 'u'
    engine_msg(self, 'use method not yet implemented')
    # use item
  when 'equip', 'e'
    engine_msg(self, 'equip method not yet implemented')
    # equip weapon
  when 'attack', 'a'
    engine_msg(self, 'attack method not yet implemented')
    puts "You swing your #{player.weapon} at the air."
    puts ''
  when 'console', 'c'
    binding.pry
  when 'quit', 'q', 'exit', 'x'
    # TODO: Add confirmation
    exit
  else
    puts 'I\'m quite sure I don\'t understand.'.colorize(:light_red)
    puts ''
  end
end

def engine_msg(messenger, msg)
  if ENGINE_MESSAGES == true
    puts '** '.colorize(:light_cyan) + messenger.class.to_s.colorize(:light_green) + ": #{msg}".colorize(:light_cyan)
    puts ''
  end
end
