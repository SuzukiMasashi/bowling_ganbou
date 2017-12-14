class LastFrame
  include Virtus.model

  def initialize(first_roll, second_roll, third_roll = 0)
    @first_roll  = first_roll
    @second_roll = second_roll
    @third_roll  = third_roll
  end

  def base_score
    @first_roll.to_i + @second_roll.to_i + @third_roll.to_i
  end

  def bonus_score
    0
  end

  def score
    base_score + bonus_score
  end

  def roll_marks
    marks = [nil, nil, nil]

    if @first_roll == Score::PIN_COUNT
      marks[0] = 'X'
    elsif @first_roll == 0
      marks[0] = 'G'
    else
      marks[0] = @first_roll.to_s
    end

    if @first_roll == Score::PIN_COUNT && @second_roll == Score::PIN_COUNT
      marks[1] = 'X'
    elsif @second_roll.to_i == 0
      marks[1] = '-'
    elsif @first_roll.to_i + @second_roll.to_i == Score::PIN_COUNT
      marks[1] = '/'
    else
      marks[1] = @second_roll&.to_s
    end

    if @third_roll == Score::PIN_COUNT
      marks[2] = @second_roll.to_i == Score::PIN_COUNT ? 'X' : '/'
    elsif @third_roll == 0
      marks[2] = 'G'
    else
      marks[2] = @third_roll&.to_s
    end

    marks.pop if marks[2].nil?
    marks
  end
end
