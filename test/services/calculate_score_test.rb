require 'test_helper'

class CalculateScoreTest < ActiveSupport::TestCase
  test '設定確認' do
    score = CalculateScore.call(nil)

    assert_equal Array.new(21) { nil }, score.roll_marks
    assert_equal Array.new(10) { nil }, score.frame_scores
    assert_nil score.total
  end

  test 'orz' do
    pins = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    score = CalculateScore.call(pins)

    assert_equal ['G','-','G','-','G','-','G','-','G','-','G','-','G','-','G','-','G','-','G','-'], score.roll_marks
    assert_equal [0,0,0,0,0,0,0,0,0,0], score.frame_scores
    assert_equal 0, score.total
  end

  test 'ダッチマン１' do
    pins = [1,9,10,3,7,10,5,5,10,7,3,10,9,1,10,0,10]
    score = CalculateScore.call(pins)

    assert_equal ['1','/','X',nil,'3','/','X',nil,'5','/','X',nil,'7','/','X',nil,'9','/','X','-','/'], score.roll_marks
    assert_equal [20,40,60,80,100,120,140,160,180,200], score.frame_scores
    assert_equal 200, score.total
  end

  test 'ダッチマン２' do
    pins = [10,2,8,10,4,6,10,6,4,10,8,2,10,0,10,10]
    score = CalculateScore.call(pins)

    assert_equal ['X',nil,'2','/','X',nil,'4','/','X',nil,'6','/','X',nil,'8','/','X',nil,'G','/','X'], score.roll_marks
    assert_equal [20,40,60,80,100,120,140,160,180,200], score.frame_scores
    assert_equal 200, score.total
  end

  test 'パーフェクト' do
    pins = [10,10,10,10,10,10,10,10,10,10,10,10]
    score = CalculateScore.call(pins)

    assert_equal ['X',nil,'X',nil,'X',nil,'X',nil,'X',nil,'X',nil,'X',nil,'X',nil,'X',nil,'X','X','X'], score.roll_marks
    assert_equal [30,60,90,120,150,180,210,240,270,300], score.frame_scores
    assert_equal 300, score.total
  end

  test '299点' do
    pins = [10,10,10,10,10,10,10,10,10,10,10,9]
    score = CalculateScore.call(pins)

    assert_equal ['X',nil,'X',nil,'X',nil,'X',nil,'X',nil,'X',nil,'X',nil,'X',nil,'X',nil,'X','X','9'], score.roll_marks
    assert_equal [30,60,90,120,150,180,210,240,270,299], score.frame_scores
    assert_equal 299, score.total
  end

  test '290点１' do
    pins = [10,10,10,10,10,10,10,10,10,10,10,0]
    score = CalculateScore.call(pins)

    assert_equal ['X',nil,'X',nil,'X',nil,'X',nil,'X',nil,'X',nil,'X',nil,'X',nil,'X',nil,'X','X','G'], score.roll_marks
    assert_equal [30,60,90,120,150,180,210,240,270,290], score.frame_scores
    assert_equal 290, score.total
  end

  test '290点２' do
    pins = [1,9,10,10,10,10,10,10,10,10,10,10,10]
    score = CalculateScore.call(pins)

    assert_equal ['1','/','X',nil,'X',nil,'X',nil,'X',nil,'X',nil,'X',nil,'X',nil,'X',nil,'X','X','X'], score.roll_marks
    assert_equal [20,50,80,110,140,170,200,230,260,290], score.frame_scores
    assert_equal 290, score.total
  end

  test '練習問題１' do
    pins = [7,2,0,8,9,1,5,5,10,8,0,7,2,10,10,9,0]
    score = CalculateScore.call(pins)

    assert_equal ['7','2','G','8','9','/','5','/','X',nil,'8','-','7','2','X',nil,'X',nil,'9','-'], score.roll_marks
    assert_equal [9,17,32,52,70,78,87,116,135,144], score.frame_scores
    assert_equal 144, score.total
  end

  test '練習問題２で９フレームまで' do
    pins = [10,10,10,9,1,0,5,5,5,6,4,8,1,10]
    score = CalculateScore.call(pins)

    assert_equal ['X',nil,'X',nil,'X',nil,'9','/','G','5','5','/','6','/','8','1','X'], score.roll_marks
    assert_equal [30,59,79,89,94,110,128,137,147], score.frame_scores
    assert_nil score.total
  end

  test '練習問題２で８フレームまで' do
    pins = [10,10,10,9,1,0,5,5,5,6,4,8,1]
    score = CalculateScore.call(pins)

    assert_equal ['X',nil,'X',nil,'X',nil,'9','/','G','5','5','/','6','/','8','1'], score.roll_marks
    assert_equal [30,59,79,89,94,110,128,137], score.frame_scores
    assert_nil score.total
  end
end
