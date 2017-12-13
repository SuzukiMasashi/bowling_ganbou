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

    # （この辺に実装）

    # scoreオブジェクトを返してください
    score
  end
end
