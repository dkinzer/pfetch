# frozen_string_literal: true

RSpec.describe Pfetch::Colenda do
  it "has configured the base_uri" do
    expect(subject.class.default_options[:base_uri]).to eq("https://colenda.library.upenn.edu")
  end

  it "is configured to parse json by default" do
    expect(subject.class.default_options[:format]).to eq(:json)
  end

  it "is configured to follow redirects by default" do
    expect(subject.class.default_options[:follow_redirects]).to be(true)
  end

  describe "::query" do
    let(:record) { Pfetch::Colenda.query("food").first }

    before do
      stub_http_response_with("colendra/food.json")
    end

    it "maps the document ids" do
      expect(record[:id]).to eq("81431-p3kp7tz3r")
    end

    it "maps the document titles" do
      expect(record[:title]).to eq("Annual report, 1959")
    end

    it "maps an abstract field" do
      abstract = ""
      expect(record[:abstract]).to eq(abstract)
    end

    it "maps the document subjects" do
      expect(record[:subjects]).to eq("Food")
    end

    it "defines a date field" do
      expect(record[:date]).to eq(1959)
    end

    it "maps a link to the record" do
      link = "https://colenda.library.upenn.edu/catalog/81431-p3kp7tz3r"
      expect(record[:link]).to eq(link)
    end

    it "defines a source field" do
      expect(record[:source]).to eq("Colenda")
    end
  end
end
