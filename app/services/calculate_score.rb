class CalculateScore
  class << self
    def call(pins)
      new(pins).call
    end
  end

  def initialize(pins)
    @pins = pins
  end

  def call
    score = Score.new

    return score if @pins.blank?

    # scoreの属性への設定例
    #
    # score.roll_marks   = ['G','-','1','/','X',nil,'1','1']
    # score.frame_scores = [0,20,32,34]
    # score.total        = score.frame_scores.last

    first_roll = true
    marks = []
    scores = []
    frames = []

    @pins.each.with_index do |pin, index|
      if pin == 10 && first_roll
        marks  << 'X'
        marks  << nil
        scores <<
          if strike = strike(index)
            strike
          else
            nil
          end
      elsif !first_roll && (@pins[index - 1] + pin) == 10
        marks  << '/'
        scores <<
          if spare = spare(index)
            spare
          else
            nil
          end
        first_roll = !first_roll
      elsif pin == 0 && first_roll
        marks  << 'G'
        first_roll = !first_roll
      elsif pin == 0 && !first_roll
        marks  << '-'
        scores << @pins[index - 1] + pin
        first_roll = !first_roll
      elsif
        marks  << pin.to_s
        scores << @pins[index - 1] + pin if !first_roll
        first_roll = !first_roll
      end
    end

    score.roll_marks = marks
    score.frame_scores = scores.map.with_index {|score, index| score.nil? ? nil : scores[0..index].sum }
    score.total = score.frame_scores[Score::FRAME_COUNT - 1]

    # scoreオブジェクトを返してください
    score
  end

  def strike(index)
    first_bonus  = @pins[index + 1]
    second_bonus = @pins[index + 2]

    return nil if first_bonus.blank? || second_bonus.blank?

    10 + first_bonus + second_bonus
  end

  def spare(index)
    first_bonus  = @pins[index + 1]

    return nil if first_bonus.blank?

    10 + first_bonus
  end
end
