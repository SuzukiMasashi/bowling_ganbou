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

    # フレームに振り分ける
    frames = split_frames(@pins)

    # roll_marksを設定
    setup_roll_marks(score, frames)

    # frame_scoresを設定
    setup_frame_scores(score, frames)

    # totalを設定
    score.total = score.frame_scores[Score::PIN_COUNT - 1]

    # scoreオブジェクトを返してください
    score
  end

  private

  def split_frames(pins)
    frames     = []
    last_index = -1

    (1..Score::FRAME_COUNT - 1).each do
      first_roll_index = last_index + 1

      break if first_roll_index == pins.length

      first_roll       = pins[first_roll_index]

      if first_roll == Score::PIN_COUNT
        second_roll = nil
        next_roll   = pins[first_roll_index + 1]
        later_roll  = pins[first_roll_index + 2]

        last_index = first_roll_index
      else
        second_roll = pins[first_roll_index + 1]

        last_index = first_roll_index + 1

        if first_roll + second_roll == Score::PIN_COUNT
          next_roll  = pins[first_roll_index + 2]
          later_roll = nil
        else
          next_roll  = nil
          later_roll = nil
        end
      end

      frames <<  NormalFrame.new(first_roll, second_roll, next_roll, later_roll)
    end

    if last_index + 1 < pins.length
      frames << LastFrame.new(pins[last_index + 1],
                              pins[last_index + 2],
                              pins[last_index + 3])
    end

    frames
  end

  def setup_roll_marks(score, frames)
    score.roll_marks = frames.map(&:roll_marks).flatten
    while score.roll_marks.last.nil? do
      score.roll_marks.pop
    end
  end

  def setup_frame_scores(score, frames)
    frames.each_with_index do |frame, index|
      if index == 0
        score.frame_scores[index] = frame.score
      else
        score.frame_scores[index] = score.frame_scores[index - 1] + frame.score
      end
    end
    while score.frame_scores.last.nil? do
      score.frame_scores.pop
    end
  end
end
