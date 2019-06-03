class TitleBracketsValidator < ActiveModel::Validator
  BRAKETS_PAIRS = %w(() {} []).freeze

  def validate(movie)
    @title = movie.title

    @opened_closed_hash = {
        "{": [],
        "}": [],
        "(": [],
        ")": [],
        "[": [],
        "]": []
    }

    begin
      @title.chars.each_with_index do |char, index|
        @opened_closed_hash[char.to_sym] << index if @opened_closed_hash.key?(char.to_sym)
      end

      analize_brackets_info
    rescue
      movie.errors.add(:base, "Wrong brackets combinations")
    end
    movie
  end

  private

  def analize_brackets_info
    BRAKETS_PAIRS.each do |braket_pair|
      openig_char_indexes = @opened_closed_hash[braket_pair[0].to_sym]
      closing_char_indexes = @opened_closed_hash[braket_pair[1].to_sym]

      if openig_char_indexes.length != closing_char_indexes.length
        raise "Wrong number of brackets"
      end

      openig_char_indexes.each_with_index do |position, index|
        if closing_char_indexes[index] < position
          raise "Bracket closed before opening"
        end

        if closing_char_indexes[index] == position + 1
          raise "Empty bracket"
        end
      end
    end
  end
end