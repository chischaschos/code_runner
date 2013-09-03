require 'typhoeus'

class CodeRunner

  def initialize args
    @type = args[:type].to_sym
    @code = args[:code].to_sym

    raise 'Unsupported language' unless apis.has_key?(@type)
  end

  def execute
    request = Typhoeus::Request.new(
      apis[@type],
      method: :post,
      params: { code: @code }
    )
    request.run
    response = request.response
    response.body
  end

  private
  def apis
    @apis ||= {
      ruby: 'http://localhost:1111',
      python: 'http://localhost:2222',
      js: 'http://localhost:3333',
      java: 'http://localhost:4444'
    }
  end
end
