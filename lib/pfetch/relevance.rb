# frozen_string_literal: true

module Pfetch::Relevance
  def relevance(string)
    lambda do |record|
      relevance = {title: 10, abstract: 5, date: 1, subjects: 1}.map { |field, weight|
        record[field].to_s.scan(/#{string.strip}/i).count * weight
      }.sum

      record.merge(relevance: relevance)
    end
  end
end
