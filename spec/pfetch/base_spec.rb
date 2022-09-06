# frozen_string_literal: true

RSpec.describe Pfetch::BaseSearch do
  it "is configured to parse json by default" do
    expect(subject.class.default_options[:format]).to eq(:json)
  end

  it "is configured to follow redirects by default" do
    expect(subject.class.default_options[:follow_redirects]).to be(true)
  end
end
