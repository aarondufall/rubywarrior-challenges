

class Player
  def initialize
    @max_health = 20
    @health = @max_health
    @dying = 7
    @healing = false
    @enermy = false
    @retreating = false
  end


  def play_turn(warrior)
    @warrior = warrior
    if safe_to_proceed?
        warrior.walk!
    else
        deal_with_challenge!
    end
    @health = warrior.health
  end 

  
  def safe_to_proceed?
    all_clear_ahead? && !under_attack? && @healing == false
  end

  def deal_with_challenge!
    inspect_ahead
    if low_health? 
      if under_attack?
        retreat!
      else
        restore_health
      end
    elsif @enermy == true
      @warrior.attack!
    else
      @warrior.rescue!
    end
  end


  def inspect_ahead
    unless @warrior.feel.captive?
      @enermy = true
    else
      @enermy = false
    end
  end
  
  #status
  def all_clear_ahead?
    @warrior.feel.empty?
  end

  def under_attack?
    @warrior.health < @health
  end

  def low_health?
    @warrior.health < @dying || @healing == true
  end



  #actions
  def restore_health
    @healing = true 
    @warrior.rest!
    @healing = false if @warrior.health == @max_health
  end

  def retreat!
    @healing = true
    @retreating = true
    @warrior.walk!(:backward)
    @retreating = false if safe_to_proceed?
  end
 

end





