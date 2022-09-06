# frozen_string_literal: true

class Pfetch::FindingAids < Pfetch::BaseSearch
  base_uri "https://findingaids.library.upenn.edu/records"
  default_params format: "json", "f[source][]": "upenn"

  def self.query(string)
    (super.dig("data") || []).map { |doc|
      id = doc["id"]
      {
        id: id,
        title: dig(doc, "title_tsi"),
        abstract: dig(doc, "abstract_scope_contents_tsi"),
        date: parse_date(dig(doc, "display_date_ssim")),
        subjects: dig(doc, "subjects_ssim"),
        link: base_uri + "/records/#{id}",
        source: "Finding Aids"
      }
    }
  end

  def self.dig(record, field)
    record.dig("attributes", field, "attributes", "value")
  end

  def self.parse_date(string)
    string.scan(/\d{4}/).first.to_i
  end
end
