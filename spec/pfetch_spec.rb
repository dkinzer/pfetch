# frozen_string_literal: true

RSpec.describe Pfetch do
  it "has a version number" do
    expect(Pfetch::VERSION).not_to be nil
  end

  it "defines a Colenda class" do
    expect(Pfetch::Colenda).to be_kind_of(Class)
  end

  it "defines a FindingAids class" do
    expect(Pfetch::FindingAids).to be_kind_of(Class)
  end
end
