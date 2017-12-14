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

    pins_by_frame = []
    roll_marks    = []
    frame_scores  = [0]

    pos = 0
    while pos < @pins.count
      if pins_by_frame.count == 9
        pins_by_frame << @pins[pos, 3]
        pos += 3
      elsif @pins[pos, 2].first == 10
        pins_by_frame << @pins[pos, 1]
        pos += 1
      else
        pins_by_frame << @pins[pos, 2]
        pos += 2
      end
    end

    counter = if pins_by_frame.count == 10
      pins_by_frame.count-1
    else
      pins_by_frame.count
    end

    pins_by_frame.take(counter).each_with_index do |frame, i|
      if frame.count == 1
        roll_marks << 'X'
        roll_marks << nil

        if pins_by_frame[i+1].nil?
          score.frame_scores = frame_scores.drop(1)
          score.roll_marks   = roll_marks[0..pins_by_frame.count - 11]
          score.total        = nil
          score

          return score
        end

        if pins_by_frame[i+1].count == 1
          frame_scores << frame_scores.last + frame.sum + pins_by_frame[i+1][0] + pins_by_frame[i+2][0]
        else
          frame_scores << frame_scores.last + frame.sum + pins_by_frame[i+1][0]+ pins_by_frame[i+1][1]
        end
      elsif frame.sum == 10
        roll_marks << frame[0].to_s
        roll_marks << '/'
        frame_scores << frame_scores.last + frame.sum + pins_by_frame[i+1][0]
      else
        if frame[0] == 0 && frame[1] == 0
          roll_marks << 'G'
          roll_marks << '-'
        elsif frame[0] == 0
          roll_marks << 'G'
          roll_marks << frame[1].to_s
        elsif frame[1] == 0
          roll_marks << frame[0].to_s
          roll_marks << '-'
        else
          roll_marks << frame[0].to_s
          roll_marks << frame[1].to_s
        end
        frame_scores << frame_scores.last + frame.sum
      end
    end

    if pins_by_frame.count == 10
      if pins_by_frame.last[0] == 0
        roll_marks << 'G'
      elsif pins_by_frame.last[0] == 10
        roll_marks << 'X'
      else
        roll_marks << pins_by_frame.last[0].to_s
      end

      if pins_by_frame.last[1] == 0
        roll_marks << '-'
      elsif pins_by_frame.last[0] == 10 && pins_by_frame.last[1] == 10
        roll_marks << 'X'
      elsif pins_by_frame.last[0] + pins_by_frame.last[1] == 10
        roll_marks << '/'
      else
        roll_marks << pins_by_frame.last[1].to_s
      end

      if pins_by_frame.last[2].present?
        if pins_by_frame.last[2] == 0
          roll_marks << 'G'
        elsif pins_by_frame.last[0] == 10 && pins_by_frame.last[1] == 0 && pins_by_frame.last[2] == 10
          roll_marks << '/'
        elsif pins_by_frame.last[0] == 0 && pins_by_frame.last[1] == 10 && pins_by_frame.last[2] == 10
          roll_marks << 'X'
        elsif pins_by_frame.last[2] == 10
          roll_marks << 'X'
        else
          roll_marks << pins_by_frame.last[2].to_s
        end
      end

      frame_scores << frame_scores.last + pins_by_frame.last.sum
    end

    score.frame_scores = frame_scores.drop(1)
    score.roll_marks   = roll_marks
    score.total        = score.frame_scores.last
    score
  end
end
