require_relative 'roman_numerals'
class Calculator
  @@base_alien_language = {}
  @@minerals_rate = {}
  @@count = 1
  def initialize
    if @@count > 0
      puts "Hello Mate! This is an Interactive Shell based programme, I follow roman numerals specify the alien language, eg: glob is X or prok is V"
    end
    @@count = 0
    @user_input = gets.chomp()
    if (@user_input =~ /is [IVXLCDM]/i)
      puts "Setting the alien language"
      @alien,@roman_equivalent = @user_input.split(" is ")
      @@base_alien_language[@alien.downcase] = @roman_equivalent.upcase
      Calculator.new()
    elsif (@user_input =~ /is [0-9]* credits/i)
      # any mineral can be registered silver gold copper anything :)
      puts "Setting the rates of Minerals"
      begin
        @alien_value = /(?<alien_language>\D+) (?<minerals>\D+) is (?<credits>\d+) credits?/i.match(@user_input)
        @total_quantity = convert_galactic_to_decimal @alien_value[:alien_language]
        # calculate per unit mineral rate
        @@minerals_rate[(@alien_value[:minerals]).downcase] = @alien_value[:credits].to_f / @total_quantity
        puts "Please continue to feed other minerals data,you can enter any minerals data eg:copper, cobalt."
        puts @@minerals_rate
        Calculator.new()
      rescue Exception => e
        puts "Error at #{e}"
      end
    elsif (@user_input =~ /how many credits?/i)
      if @@minerals_rate.empty?
        puts "Please enter the minerals information like, glob glob Silver is 34 Credits"
      else
        begin
          @total = /how many credits? is (?<alien_language>\D+) (?<minerals>\D+)\?/i.match(@user_input)
          total_credits = (convert_galactic_to_decimal @total[:alien_language]) * @@minerals_rate.fetch("#{@total[:minerals].strip.downcase.to_s}").to_f
          puts "#{@total[:alien_language]} #{@total[:minerals]} is #{total_credits}"
          Calculator.new()
        rescue Exception => e
           puts "Press CTRL + C to exit,Exception #{e}"
           Calculator.new()
        end
      end
    elsif (@user_input =~ /how much is/i)
      if @@minerals_rate.empty?
        puts "Please enter the minerals information like, glob glob Silver is 34 Credits"
      else
        begin
          @galatic_number = /how much is (?<alien_language>\D+)\?/i.match(@user_input)
          puts "#{@galatic_number[:alien_language]} is #{convert_galactic_to_decimal @galatic_number[:alien_language]}"
          Calculator.new()
        rescue Exception => e
          puts "Press CTRL + C to exit, Exception #{e}"
          Calculator.new()
        end
      end
    else
      puts "I have no idea what you are talking about, Press CTRL + C to exit"
      Calculator.new()
    end
  end

  def convert_galactic_to_decimal galatic_number
    @galatic_number = galatic_number
    begin
        @@base_alien_language.each_pair { |k,val|
          @galatic_number = @galatic_number.downcase.gsub(k.to_s,val.to_s)
        }
        return RomanNumerals.to_decimal(@galatic_number.gsub(" ",""))
      rescue Exception => e
        puts "Error while converting into decimals #{e}"
      end
    end
  Calculator.new()
end