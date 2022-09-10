# frozen_string_literal: true

module Pfetch::Relevance
  def relevance(string)
    weights = {title: 10, abstract: 5, date: 1, subjects: 1}

    # Sum up all occurances of a substring in each field by associated weight.
    weigh = lambda do |sub_string, record|
      weights.map { |field, weight|
        record[field].to_s.scan(/#{sub_string.strip}/i).count * weight
      }.sum
    end

    lambda do |record|
      # Boost multi term phrase match.
      relevance = weigh.call(string, record)

      if string.split.count > 1
        relevance += string.split.map { |sub_string| weigh.call(sub_string, record) }.sum
      end

      record.merge(relevance: relevance)
    end
  end
end
