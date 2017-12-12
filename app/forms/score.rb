class Score
  include Virtus.model

  FRAME_COUNT = 10
  ROLL_COUNT = (FRAME_COUNT - 1) * 2 + 3

  attribute :roll_marks, Array, default: Array.new(ROLL_COUNT) { nil }
  attribute :frame_scores, Array, default: Array.new(FRAME_COUNT) { nil }
  attribute :total, Integer
end
