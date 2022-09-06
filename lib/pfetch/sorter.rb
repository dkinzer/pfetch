# frozen_string_literal: true

module Pfetch::Sorter
  def sorter(type)
    case type
    when :date, :relevance
      lambda { |rec| -rec[type] }
    else
      lambda { |rec| rec[type] }
    end
  end
end
