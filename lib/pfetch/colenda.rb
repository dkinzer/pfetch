# frozen_string_literal: true

class Pfetch::Colenda < Pfetch::BaseSearch
  base_uri "https://colenda.library.upenn.edu"
  default_params format: "json", search_field: "all", utf8: "✓"

  def self.query(string)
    (super.dig("response", "docs") || []).map { |doc|
      id = doc["id"]
      {
        id: id,
        title: doc["title_tesim"]&.first.to_s,
        abstract: doc["abstract_tesim"]&.first.to_s,
        date: doc["date_tesim"]&.first.to_i,
        subjects: doc["subject_tesim"]&.join(", "),
        link: base_uri + "/catalog/#{id}",
        source: "Colenda"
      }
    }
  end
end
