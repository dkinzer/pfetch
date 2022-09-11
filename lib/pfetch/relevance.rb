# frozen_string_literal: true

module Pfetch::Relevance
  def relevance(string)
    weights = {title: 10, abstract: 5, date: 1, subjects: 1}

    # Allow weighing in multiple contexts.
    weigh = lambda do |sub_string, record|
      weights.map { |field, weight|
        record[field].to_s.scan(/#{sub_string.strip}/i).count * weight
      }.sum
    end

    lambda do |record|
      # Boost the multi term full phrase match.
      relevance = weigh.call(string, record)

      if string.split.count > 1
        # Boost individual matches for the tokenized phrase.
        relevance += string.split.map { |sub_string| weigh.call(sub_string, record) }.sum
      end

      record.merge(relevance: relevance)
    end
  end
end
