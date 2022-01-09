class ResultPresenter
  def initialize(output, tests)
    @results = JSON.parse(CGI.unescape(output)).map(&:symbolize_keys)
    @tests = tests
  end

  def sort
    test_names.map do |name|
      @results.find { |test| test[:name] == name  }
    end
  end

  def test_names
    @tests.scan(/def (test_\S*)/).flatten
  end
end
