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

  # 0 = th, 1 = ng, 2 = ch, 3 = sh 

  def initialize (wd)
    @word = Array.new
    @cv = Array.new
    wd.downcase!
    
    # change cons clusters into equivalents
    wd.gsub!(/th/,"0")
    wd.gsub!(/ng/,"1")   
    wd.gsub!(/ch/,"2")
    wd.gsub!(/sh/,"3")

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
    wd = String.new
    wd = @word.to_s
    # change equivalents into clusters
    wd.gsub!(/0/,"th")
    wd.gsub!(/1/,"ng")   
    wd.gsub!(/2/,"ch")
    wd.gsub!(/3/,"sh")
    wd.capitalize!
    return wd
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
    
    return @word
  end
end


# ******* CLASS: phonetic form with lookup table to distort things *******

class Phon
  def initialize (phon)
    @phon = phon
  end

  def phon
    return @phon
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
        cand = ["v0ds23gh"]
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
        cand = ["pv0s2h"]
      elsif dist == 2
        cand = ["btkz3"]
      end
    elsif @phon == "v"
      if dist == 0
        cand = ["v"]
      elsif dist == 1
        cand = ["fbz"]
      elsif dist == 2
        cand = ["p0s3hdgmw"]
      end
    elsif @phon == "m"
      if dist == 0
        cand = ["m"]
      elsif dist == 1
        cand = ["wn1"]
      elsif dist == 2
        cand = ["vblrj"]
      end
    elsif @phon == "w"
      if dist == 0
        cand = ["w"]
      elsif dist == 1
        cand = ["mj"]
      elsif dist == 2
        cand = ["m1vblr"]
      end
    elsif @phon == "0"
      if dist == 0
        cand = ["0"]
      elsif dist == 1
        cand = ["fs3h"]
      elsif dist == 2
        cand = ["vzptk2"]
      end
    elsif @phon == "t"
      if dist == 0
        cand = ["t"]
      elsif dist == 1
        cand = ["spkd"]
      elsif dist == 2
        cand = ["hf0zbg23"]
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
        cand = ["tzhf03"]
      elsif dist == 2
        cand = ["dpk2v"]
      end
    elsif @phon == "z"
      if dist == 0
        cand = ["z"]
      elsif dist == 1
        cand = ["sdv"]
      elsif dist == 2
        cand = ["thf023bgnlr"]
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
    elsif @phon == "2"
      if dist == 0
        cand = ["2"]
      elsif dist == 1
        cand = ["3"]
      elsif dist == 2
        cand = ["st0fhpk"]
      end
    elsif @phon == "3"
      if dist == 0
        cand = ["3"]
      elsif dist == 1
        cand = ["2s0fh"]
      elsif dist == 2
        cand = ["tpkzv"]
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
        cand = ["dbshf023"]
      end
    elsif @phon == "g"
      if dist == 0
        cand = ["g"]
      elsif dist == 1
        cand = ["kdb"]
      elsif dist == 2
        cand = ["tp1zv"]
      end
    elsif @phon == "1"
      if dist == 0
        cand = ["1"]
      elsif dist == 1
        cand = ["nm"]
      elsif dist == 2
        cand = ["gjwrl"]
      end
    elsif @phon == "h"
      if dist == 0
        cand = ["h"]
      elsif dist == 1
        cand = ["fs03"]
      elsif dist == 2
        cand = ["vzptk2"]
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

    return new_phon
  end
end

# ------------ BEGIN MAIN PART OF CODE ------------

# get inputs
input_wd = String.new
dist = Numeric.new
num_phons = Numeric.new
input_wd << ARGV[0] # word to change
num_phons = ARGV[1].to_i # number of phonemes to change
dist =  ARGV[2].to_i # number of features to change

# choose the consonanta to change
word = CVform.new(input_wd)
cons = word.cons

# check there are enough things to change
if cons.length < num_phons
  print "Not enough consonants to change, changing only " + cons.length.to_s + ".\n"
  num_phons = cons.length
end

already_changed = Array.new

# walk through and change the consonants
for i in 0...num_phons
  idx_to_change = rand(cons.length)
  while already_changed.include?(idx_to_change)
    idx_to_change = rand(cons.length)
  end    
  cons_to_change = Phon.new(cons[idx_to_change])
  cons[idx_to_change] = cons_to_change.perm(dist)

  already_changed << idx_to_change
  #print i.to_s + " " + cons_to_change.phon.to_s + " " + idx_to_change.to_s +  "\n"
end

# replace the changed consonants
word.newcons(cons)

# print the output
print word.word.to_s + "\n"


# ------------ END MAIN PART OF CODE ------------

