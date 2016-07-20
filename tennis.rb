class TennisGame2

  def initialize(player1Name, player2Name)
    @player1Name = player1Name
    @player2Name = player2Name
    @p1points = 0
    @p2points = 0
    # object of player?
  end

  def won_point(playerName)
    if playerName == @player1Name
      p1Score()
    else
      p2Score()
    end
  end

  # returns natural language result
  def score
    # this is sequentially checking scores and returning values
    # what might be a better way?
    # It feels like switching states, which are not visible,
    #   and then mapping these states to the natural language
    #   output.
    #
    # Love/Fifteen/.../Forty is inner level of mapping.
    #   for the scores the "inner loop"
    # The outer states are All, Advantage, Win, etc. determined
    #   by difference/comparing.
    #
    names1 = [ "Love", "Fifteen", "Thirty", "Forty", "Advantage #{@player1Name}" ]
    names2 = [ "Love", "Fifteen", "Thirty", "Forty", "Advantage #{@player2Name}" ]
      
    result = ""
    # equal and low score
    if (@p1points == @p2points and @p1points < 3)
      result = names1[@p1points]
      result += "-All"
    end
    # equal and high score
    if (@p1points==@p2points and @p1points>2)
      result = "Deuce"
    end

    p1res = ""
    p2res = ""
    # player 1 has sth, player 2 has nothing
    if (@p1points > 0 and @p2points==0)
      p2res = names2[@p2points]
      p1res = names1[@p1points]
      result = p1res + "-" + p2res
    end
    # player 2 is leading (the reverse) duplicated
    if (@p2points > 0 and @p1points==0)
      p2res = names2[@p2points]
      p1res = names1[@p1points]
      result = p1res + "-" + p2res
    end

    # duplicated blocks, player 1 leading but with low score
    if (@p1points>@p2points and @p1points < 4)
      p1res = names1[@p1points]
      p2res = names2[@p2points]
      result = p1res + "-" + p2res
    end
    if (@p2points>@p1points and @p2points < 4)
      p1res = names1[@p1points]
      p2res = names2[@p2points]
      result = p1res + "-" + p2res
    end

    # one is leading with hi score
    if (@p1points > @p2points and @p2points >= 3)
      result = names1[[@p1points, 4].min]
    end
    if (@p2points > @p1points and @p1points >= 3)
      result = names2[[@p2points, 4].min]
    end

    # wins when >= 2 more score and high score
    if (@p1points>=4 and @p2points>=0 and (@p1points-@p2points)>=2)
      result = "Win for " + @player1Name
    end
    if (@p2points>=4 and @p1points>=0 and (@p2points-@p1points)>=2)
      result = "Win for " + @player2Name
    end
    result
  end

  def setp1Score(number)
    (0..number).each do |i|
      p1Score()
    end
  end

  def setp2Score(number)
    (0..number).each do |i|
      p2Score()
    end
  end

  def p1Score
    @p1points +=1
  end

  def p2Score
    @p2points +=1
  end
end

