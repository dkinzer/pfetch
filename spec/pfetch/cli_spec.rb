# frozen_string_literal: true

RSpec.describe Pfetch::Cli do
  describe "::pull" do
    let(:subject) { Pfetch::Cli.run(query_string: "food") }

    before do
      stub_finding_aids_request(fixture: "food.json")
      stub_colenda_request(fixture: "food.json")
    end

    it "combines the two results" do
      expect(subject.count).to eq(20)
    end

    it "maps a relevance to each of the results" do
      expect(subject).to all(have_key(:relevance))
    end

    it "sorts titles by default" do
      titles = subject.map { |rec| rec[:title] }
      expect(titles).to eq(titles.sort)
    end

    context "when sorting by date" do
      let(:subject) { Pfetch::Cli.run(query_string: "food", sort_field: :date) }
      it "sorts records by date starting from most recent" do
        dates = subject.map { |rec| rec[:date] }
        expect(dates).to eq(dates.sort.reverse!)
      end
    end

    context "when sorting by relevance" do
      let(:subject) { Pfetch::Cli.run(query_string: "food", sort_field: :relevance) }

      it "sorts records by relevance starting from most relevant" do
        relevances = subject.map { |rec| rec[:relevance] }
        expect(relevances).to eq(relevances.sort.reverse!)
      end
    end
  end
end
