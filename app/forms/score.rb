class Score
  include Virtus.model

  attribute :frame_count,  Integer
  attribute :frame_scores, Array,   default: :default_frame_scores
  attribute :roll_count,   Integer, default: :default_roll_count
  attribute :roll_marks,   Array,   default: :default_roll_marks
  attribute :total,        Integer

  private

  def default_frame_scores
    Array.new(frame_count) { nil }
  end

  def default_roll_count
    (frame_count - 1) * 2 + 3
  end

  def default_roll_marks
    Array.new(roll_count) { nil }
  end
end
