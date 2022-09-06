# frozen_string_literal: true

RSpec.describe Pfetch::FindingAids do
  it "has configured the base_uri" do
    expect(subject.class.default_options[:base_uri]).to eq("https://findingaids.library.upenn.edu/records")
  end

  it "is configured to parse json by default" do
    expect(subject.class.default_options[:format]).to eq(:json)
  end

  it "is configured to follow redirects by default" do
    expect(subject.class.default_options[:follow_redirects]).to be(true)
  end

  describe "::query" do
    let(:record) { Pfetch::FindingAids.query("food").first }

    before do
      stub_http_response_with("finding_aids/food.json")
    end

    it "maps the document ids" do
      expect(record[:id]).to eq("UPENN_RBML_PUSP.MS.COLL.1004")
    end

    it "maps the document titles" do
      expect(record[:title]).to eq("Esther B. Aresty papers")
    end

    it "maps an abstract field" do
      abstract = "Esther B. Aresty (1908-2000) was a cookbook collector and culinary historian who wrote on food, cooking and etiquette. This collection documents Aresty&#39;s personal and professional activities, primarily through correspondence, publication drafts, and research materials regarding her books, entitled The Grand Venture (1963), The Delectable Past (1964), The Best Behavior (1970), and The Exquisite Table (1980)."

      expect(record[:abstract]).to match(abstract)
    end

    it "maps the document subjects" do
      expect(record[:subjects]).to eq("Women authors, Etiquette, Cookbooks, Cooking, Authors, and Authors, American -- 20th century")
    end

    it "defines a date field" do
      expect(record[:date]).to eq(1937)
    end

    it "maps a link to the record" do
      link = "https://findingaids.library.upenn.edu/records/records/UPENN_RBML_PUSP.MS.COLL.1004"
      expect(record[:link]).to eq(link)
    end

    it "defines a source field" do
      expect(record[:source]).to eq("Finding Aids")
    end
  end
end
