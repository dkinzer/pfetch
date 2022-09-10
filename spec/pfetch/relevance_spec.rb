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

      it "append a zero orelevance" do
        expect(relevance.call(record)[:relevance]).to eq(0)
      end
    end

    context "When multi term field and one substring matches" do
      let(:relevance) { subject.relevance("zzzz bizz") }

      it "append weight for the one term" do
        expect(relevance.call(record)[:relevance]).to eq(10)
      end
    end

    context "When multi term field and all substring match but not together" do
      let(:relevance) { subject.relevance("my bizz") }

      it "append summed weight of each substring" do
        expect(relevance.call(record)[:relevance]).to eq(20)
      end
    end

    context "When multi term field matches exactly" do
      let(:relevance) { subject.relevance("my foo") }

      it "append summed weight of each substring plus weight of full phrase match" do
        expect(relevance.call(record)[:relevance]).to eq(40)
      end
    end
  end
end
