class CalculateScore
  class << self
    def call(pins)
      new(pins).call
    end
  end

  def initialize(pins)
    @score  = Score.new(frame_count: 10)
    @frames = []
    @pins   = pins
  end

  def call
    return @score if @pins.blank?

    # scoreの属性への設定例
    #
    # score.roll_marks   = ['G','-','1','/','X',nil,'1','1']
    # score.frame_scores = [0,20,32,34]
    # score.total        = score.frame_scores.last

    current_frame = Frame.new(frame_no: 1)

    @pins.each do |pin|
      current_frame.add_pin(pin)

      next unless current_frame.done?

      @frames.push current_frame
      frame_no = @frames.size + 1
      current_frame = Frame.new(frame_no: frame_no, last_frame: @score.frame_count == frame_no)
    end

    binding.pry


    # scoreオブジェクトを返してください
    @score
  end

end
