# frozen_string_literal: true

require "httparty"
require "pfetch/relevance"

class Pfetch::BaseSearch
  include HTTParty
  extend Pfetch::Relevance

  follow_redirects true
  format :json

  base_uri "https://colenda.library.upenn.edu"
  default_params format: "json", search_field: "all", utf8: "✓"

  def self.query(string)
    get("", query: {q: string})
  rescue
    {}
  end
end
