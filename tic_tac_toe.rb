# frozen_string_literal: true

Success_array = [[1, 2, 3], [1, 4, 7], [1, 5, 9], [2, 5, 8], [3, 6, 9], [3, 5, 7], [4, 5, 6], [7, 8, 9]].freeze

def display_board(board)
  puts "  #{board[0]}  |  #{board[1]}  |  #{board[2]}  "
  puts '----------------------'
  puts "  #{board[3]}  |  #{board[4]}  |  #{board[5]}  "
  puts '----------------------'
  puts "  #{board[6]}  |  #{board[7]}  |  #{board[8]}  "
  puts "\n"
  puts "\n"
end

def get_input(palo = 'Player')
  puts "Enter the #{palo} desired location [1-9]"
  gets.chomp.to_i
end

def check_validity(x, board)
  if board[x - 1] == ' '
    true
  else
    puts 'Please enter the right position'
    false
  end
end

def update_board(x, board, turn)
  board[x - 1] = if turn.even?
                   'X'
                 else
                   'O'
                 end
  board
end

def update_turn(turn)
  (turn + 1)
end

def check_success(check_array)
  y = Success_array.length
  z = 0
  while y != z
    if (check_array & Success_array[z]).length == 3
      return 1
    else
      z += 1
    end
  end
  0 if z == y
end

def start(mode)
  x_entered = []
  o_entered = []
  game_over = 0
  board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
  display_board(board)
  turn = 0
  sample_array = [1, 2, 3, 4, 5, 6, 7, 8, 9] if mode == '1'
  while game_over.zero?
    is_position_accurate = false
    # get input and check validity for input
    if mode == '2'
      until is_position_accurate
        palo = if turn.even?
                 'X'
               else
                 'O'
               end
        x = get_input(palo) # return entered position
        is_position_accurate = check_validity(x, board)

      end
    end

    if mode == '1'
      until is_position_accurate
        if turn.even?
          x = get_input       # return entered position palo
        else
          sample_array = (sample_array - x_entered) - o_entered
          x = sample_array.sample

        end
        is_position_accurate = check_validity(x, board)
      end
    end
    if turn.even?
      x_entered.push(x)
    else
      o_entered.push(x)
    end

    board = update_board(x, board, turn)
    display_board(board)
    if turn > 3
      game_over = if turn.even?
                    check_success(x_entered.sort)
                  else
                    check_success(o_entered.sort)
                  end
    end
    if game_over == 1
      puts "#{palo} has won the match" if mode == '2'
      if mode == '1'
        if turn.even?
          puts 'Player won the match'
        else
          puts 'Computer won the match'
        end
      end
    end

    if turn >= 8
      game_over = 1
      puts('Match is Draw')
    end

    turn = update_turn(turn)

  end
end

def select_mode
  puts 'Welcome to Tic Tac Toe'
  puts '1: Single Player'
  puts '2 : Multi Player'
  puts 'Enter the mode you want to play: 1/2'
  mode = gets.chomp

  start(mode)
end

select_mode

loop do
  puts 'Do you want to play Next Game: Y/N'
  input = gets.chomp
  if %w[Y y].include?(input)
    select_mode
  else
    puts 'Thanks For Playing'
    break

  end
end
