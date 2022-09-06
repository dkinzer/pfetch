# frozen_string_literal: true

RSpec.describe Pfetch::Sorter do
  let(:subject) { instance_double(Object) }

  before do
    subject.extend(Pfetch::Sorter)
  end

  describe "#sorter" do
    let(:records) {
      [
        {title: "c", date: 2, relevance: 3},
        {title: "b", date: 1, relevance: 2},
        {title: "a", date: 3, relevance: 1}
      ]
    }
    context "when title" do
      let(:sorter) { subject.sorter(:title) }

      it "sorts by title A-Z" do
        expect(records.sort_by(&sorter)).to eq([
          {title: "a", date: 3, relevance: 1},
          {title: "b", date: 1, relevance: 2},
          {title: "c", date: 2, relevance: 3}
        ])
      end
    end

    context "when date" do
      let(:sorter) { subject.sorter(:date) }

      it "sorts by latest first" do
        expect(records.sort_by(&sorter)).to eq([
          {title: "a", date: 3, relevance: 1},
          {title: "c", date: 2, relevance: 3},
          {title: "b", date: 1, relevance: 2}
        ])
      end
    end

    context "relevance" do
      let(:sorter) { subject.sorter(:relevance) }

      it "sorts by most relevant first" do
        expect(records.sort_by(&sorter)).to eq([
          {title: "c", date: 2, relevance: 3},
          {title: "b", date: 1, relevance: 2},
          {title: "a", date: 3, relevance: 1}
        ])
      end
    end
  end
end
