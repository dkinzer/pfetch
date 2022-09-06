# frozen_string_literal: true

class Pfetch::Cli
  extend Pfetch::Sorter
  extend Pfetch::Relevance

  def self.run(query_string:, sort_field: :title)
    sorter = sorter(sort_field)
    relevance = relevance(query_string)

    [Pfetch::FindingAids, Pfetch::Colenda]
      .map { |search_class| Thread.new { search_class.query(query_string) } }
      .map(&:value)
      .reduce(&:+)
      .map(&relevance)
      .sort_by(&sorter)
  end
end
