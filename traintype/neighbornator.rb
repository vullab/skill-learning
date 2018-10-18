#!/usr/bin/ruby

# neighbornator.rb
# mcfrank 1/6/07
# very simple but potentially extensible script to read in a word, replace a random 
# consonant with a phonetic neighbor that varies by some # of features, taken from
# bailey & hahn (2005). 

# usage: neighbornator word distance
# e.g.: neighbornator hello 1
# produces: fello, thello, sello, jello

# ******* CLASS: consonant/vowel form of a word *********
class CVform

  def initialize (wd)
    @word = Array.new
    @cv = Array.new
    wd.downcase!
    for i in 0...wd.length
      lett = String.new
      lett << wd[i]
      if not lett.grep(/(a|e|i|o|u|y)/).empty?
        @cv[i] = "V"
      else
        @cv[i] = "C"
      end
      @word[i] = lett
    end
  end

  def word
    return @word
  end

  def cv
    return @cv
  end

  def lonecons
    cons = Array.new
    @cv.each_index do |i|
      if @cv[i] == "C" # if it's a consonant
        if i > 0 and i < @cv.length - 1 # and we're in the middle
          if @cv[i-1] == "V" and @cv[i+1] == "V" # and we're surrounded by vowels
            cons << @word[i]
          end
        elsif i == 0 and @cv[i+1] == "V" # or we're at the beginning
          cons << @word[i]
        elsif i == @cv.length - 1 and @cv[i-1] == "V" # or we're at the end
          cons << @word[i]
        end
      end
    end
    return cons
  end

  def cons
    cons = Array.new
    @cv.each_index do |i|
      if @cv[i] == "C" # if it's a consonant
        cons << @word[i]
      end
    end
    return cons
  end

  def newcons(cons)
    j = 0
    @cv.each_index do |i|
      if @cv[i] == "C"
        @word[i] = cons[j]
        j += 1
      end
    end
    return @word
  end

  def newlonecons(cons)
    j = 0

    @cv.each_index do |i|
      if @cv[i] == "C" # if it's a consonant
        if i > 0 and i < @cv.length - 1 # and we're in the middle
          if @cv[i-1] == "V" and @cv[i+1] == "V" # and we're surrounded by vowels
            @word[i] = cons[j]
            j += 1
          end
        elsif i == 0 and @cv[i+1] == "V" # or we're at the beginning
          @word[i] = cons[j]
          j += 1
        elsif i == @cv.length - 1 and @cv[i-1] == "V" # or we're at the end
          @word[i] = cons[j]
          j += 1
        end      
      end
    end
    
    return word
  end
end


# ******* CLASS: phonetic form with lookup table to distort things *******

class Phon
  def initialize (phon)
    @phon = phon
  end

  def perm (dist)
    new_phon = String.new

    
    # incredibly ugly lookup table for one/two neighbors away from some character
    if @phon == "p"
      if dist == 0
        cand = ["p"]
      elsif dist == 1
        cand = ["bftk"]
      elsif dist == 2
        cand = ["hdsgh"]
      end
    elsif @phon == "b"
      if dist == 0
        cand = ["b"]
      elsif dist == 1
        cand = ["pvdg"]
      elsif dist == 2
        cand = ["ftkmwz"]
      end
    elsif @phon == "f"
      if dist == 0
        cand = ["f"]
      elsif dist == 1
        cand = ["pvhs0"]
      elsif dist == 2
        cand = ["btkz"]
      end
    elsif @phon == "v"
      if dist == 0
        cand = ["v"]
      elsif dist == 1
        cand = ["fbz"]
      elsif dist == 2
        cand = ["phs0dgmw"]
      end
    elsif @phon == "m"
      if dist == 0
        cand = ["m"]
      elsif dist == 1
        cand = ["wn1"]
      elsif dist == 2
        cand = ["fblrj"]
      end
    elsif @phon == "w"
      if dist == 0
        cand = ["w"]
      elsif dist == 1
        cand = ["mj"]
      elsif dist == 2
        cand = ["m1vblr"]
      end
    elsif @phon == "h"
      if dist == 0
        cand = ["h"]
      elsif dist == 1
        cand = ["fs0"]
      elsif dist == 2
        cand = ["vzptk"]
      end
    elsif @phon == "t"
      if dist == 0
        cand = ["t"]
      elsif dist == 1
        cand = ["spkd"]
      elsif dist == 2
        cand = ["hf0zbg"]
      end
    elsif @phon == "d"
      if dist == 0
        cand = ["d"]
      elsif dist == 1
        cand = ["tzbg"]
      elsif dist == 2
        cand = ["spkvnlr"]
      end
    elsif @phon == "s"
      if dist == 0
        cand = ["s"]
      elsif dist == 1
        cand = ["tzhf0"]
      elsif dist == 2
        cand = ["dpkv"]
      end
    elsif @phon == "z"
      if dist == 0
        cand = ["z"]
      elsif dist == 1
        cand = ["sdv"]
      elsif dist == 2
        cand = ["thf0bgnlr"]
      end
    elsif @phon == "n"
      if dist == 0
        cand = ["n"]
      elsif dist == 1
        cand = ["lrm1"]
      elsif dist == 2
        cand = ["zdwj"]
      end
    elsif @phon == "l"
      if dist == 0
        cand = ["l"]
      elsif dist == 1
        cand = ["nr"]
      elsif dist == 2
        cand = ["m1zdwj"]
      end
    elsif @phon == "r"
      if dist == 0
        cand = ["r"]
      elsif dist == 1
        cand = ["ln"]
      elsif dist == 2
        cand = ["m1zdwj"]
      end
    elsif @phon == "j"
      if dist == 0
        cand = ["j"]
      elsif dist == 1
        cand = ["w"]
      elsif dist == 2
        cand = ["rlnm1"]
      end
    elsif @phon == "k"
      if dist == 0
        cand = ["k"]
      elsif dist == 1
        cand = ["gtp"]
      elsif dist == 2
        cand = ["dbshf0"]
      end
    elsif @phon == "g"
      if dist == 0
        cand = ["g"]
      elsif dist == 1
        cand = ["kdb"]
      elsif dist == 2
        cand = ["tp1zv"]
      end
    else
      cand = ["X"]
    end
  
    cand = cand.to_s
    cands = Array.new
    
    for i in 0...cand.length
      lett = String.new
      lett << cand[i]
      cands[i] = lett
    end    

    idx = rand(cands.length)
    new_phon = cands[idx]


    # convert back from weird phone codes
    if new_phon == "1"
      new_phon = "ng"
    elsif new_phon == "0"
      new_phon = "th"
    end

    return new_phon
  end
end

# ------------ BEGIN MAIN PART OF CODE ------------

# get inputs
input_wd = String.new
dist = Numeric.new
input_wd << ARGV[0] # word to change
dist =  ARGV[1].to_i # number of features to change

# choose the consonant to change
word = CVform.new(input_wd)
cons = word.lonecons
idx_to_change = rand(cons.length)
cons_to_change = Phon.new(cons[idx_to_change])

# change it by distance dist
cons[idx_to_change] = cons_to_change.perm(dist)
word.newlonecons(cons)

# print the output
print word.word.to_s + "\n"


# ------------ END MAIN PART OF CODE ------------

