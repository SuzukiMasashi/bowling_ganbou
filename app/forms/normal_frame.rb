class NormalFrame
  include Virtus.model

  def initialize(first_roll, second_roll, next_roll, later_roll)
    @first_roll  = first_roll
    @second_roll = second_roll
    @next_roll   = next_roll
    @later_roll  = later_roll
  end

  def base_score
    @first_roll.to_i + @second_roll.to_i
  end

  def bonus_score
    return @next_roll.to_i + @later_roll.to_i if @first_roll == Score::PIN_COUNT
    return @next_roll                         if base_score == Score::PIN_COUNT
    0
  end

  def score
    base_score + bonus_score
  end

  def roll_marks
    # return ['X', nil]                if @first_roll == Score::PIN_COUNT
    # return ['F', @second_roll&.to_s] if @first_roll.nil?
    # return ['G', @second_roll&.to_s] if @first_roll == 0
    # return [@first_roll.to_s, '/']   if base_score == Score::PIN_COUNT
    # return [@first_roll.to_s, '-']   if @first_roll > 0 && @second_roll.to_i == 0
    # [@first_roll&.to_s, @second_roll&.to_s]

    marks = [nil, nil]

    if @first_roll == Score::PIN_COUNT
      marks[0] = 'X'
    elsif @first_roll == 0
      marks[0] = 'G'
    else
      marks[0] = @first_roll.to_s
    end

    if @first_roll != Score::PIN_COUNT && base_score == Score::PIN_COUNT
      marks[1] = '/'
    elsif @second_roll == 0
      marks[1] = '-'
    else
      marks[1] = @second_roll&.to_s
    end

    marks
  end
end
