require 'spec_helper'

describe 'Validation Example' do
  SEARCH_FIELDS = %w[ref ref_anixe contract agency status search date_status_modified date_cancelled date_from billing description product]

  it 'works' do
    params = { :ref_anixe => '2abc', :page => 1 }

    module Verify
      def verify(m, *args)
        method(m).to_proc.curry.call(*args)
      end

      def max_len(length, s)
        Either(s.length <= length).else("Max length is #{length}")
      end

      def only_chars(s)
        Either(s =~ /^[A-Z0-9]+$/).else("Only [A-Z0-9] chars allowed")
      end
    end

    extend Verify

    validations = {
      :ref_anixe => [ verify(:max_len, 4), verify(:only_chars) ]
    }

    result = validations.map { |key, conditions|
      value = params.fetch(key, Failure("Param #{key} not found"))
      [key, conditions.map { |e| res = e.(params[key]) }]
    }
    p Hash[result]
    # :page
    # :search

  end
end
