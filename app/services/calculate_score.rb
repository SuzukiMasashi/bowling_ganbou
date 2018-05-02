class CalculateScore
  class << self
    def call(*pins)
      new(pins).call
    end
  end

  def initialize(pins)
    @pins = pins
  end

  def call
    score = Score.new
    game_score = 0
    count = 0
    frame_scores_count = 0

    return score if @pins.blank?

    # scoreの属性への設定例
    # score.roll_marks   = ['G','-','1','/','X',nil,'1','1']
    # score.frame_scores = [0,20,32,34]
    # score.total        = score.frame_scores.last

    @pins.each do |pin|
      binding.pry
      game_score += pin
      count += 1

      if game_score >= 10 || count == 3
        score.frame_scores[frame_scores_count] = game_score
        frame_scores_count += 1
        game_score = 0
        count = 0
      end
    end


    # scoreオブジェクトを返してください
    score
  end
end
