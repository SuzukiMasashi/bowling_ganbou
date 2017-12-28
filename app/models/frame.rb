class Frame
  class << self
    def build(score)
      (1..score.frame_count).map do |frame_no|
        new(frame_no: frame_no, last_frame: frame_no == frame_count)
      end
    end
  end

  def initialize(frame_no: nil, last_frame: false)
    @frame_no   = frame_no
    @last_frame = last_frame
    @rolls      = []
  end

  def done?
    @rolls.size == rolls_size
  end

  def add_pin(pin)
   !@last_frame && strike?(pin) ? @rolls.push(pin, nil) : @rolls.push(pin)
  end

  private

  def strike?(pin)
    first_throw? && pin == 10
  end

  def rolls_size
    @last_frame ? 3 : 2
  end

  def first_throw?
    @rolls.size.even?
  end
end
