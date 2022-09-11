# frozen_string_literal: true

class Pfetch::Cli
  extend Pfetch::Sorter
  extend Pfetch::Relevance

  def self.run(query_string:, sort_field: :title)
    sorter = sorter(sort_field)
    relevance = relevance(query_string)

    # Get list of records and merge via thread for efficiency.
    records = [Pfetch::FindingAids, Pfetch::Colenda]
      .map { |search_class| Thread.new { search_class.query(query_string) } }
      .map(&:value).reduce(&:+)

    records.map(&relevance)
      .sort_by(&sorter)
  end
end
