# frozen_string_literal: true

RSpec.describe Pfetch::Relevance do
  let(:subject) { instance_double(Object) }

  let(:record) {
    {
      title: "My foo is foo, bizz",
      abstract: "bar bar",
      date: 1984,
      subjects: "buzz"
    }
  }

  before do
    subject.extend(Pfetch::Relevance)
  end

  describe "#relevance" do
    context "when title contains search_string" do
      let(:relevance) { subject.relevance("foo") }

      it "append multiple of 10 relevance" do
        expect(relevance.call(record)[:relevance]).to eq(20)
      end
    end

    context "when abstract contains search_string" do
      let(:relevance) { subject.relevance("bar") }

      it "append multiple of 5 relevance" do
        expect(relevance.call(record)[:relevance]).to eq(10)
      end
    end

    context "when subjects contains search_string" do
      let(:relevance) { subject.relevance("buzz") }

      it "append multiple of 1 relevance" do
        expect(relevance.call(record)[:relevance]).to eq(1)
      end
    end

    context "when date contains search_string" do
      let(:relevance) { subject.relevance("1984") }

      it "append multiple of 1 relevance" do
        expect(relevance.call(record)[:relevance]).to eq(1)
      end
    end

    context "when no fields contains search_string" do
      let(:relevance) { subject.relevance("zzzz") }

      it "append a zer orelevance" do
        expect(relevance.call(record)[:relevance]).to eq(0)
      end
    end
  end
end
