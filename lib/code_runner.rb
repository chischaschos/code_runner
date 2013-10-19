module CodeRunner
  extend self

  attr_writer :executer

  def self.execute args
    type = args[:type].to_sym
    code = args[:code]

    raise 'Unsupported language' unless executer.supports?(type)

    executer.execute type, code
  end

  private

  def self.executer
    @executer ||= CodeRunner::NetworkExecuter.new
  end
end

require 'code_runner/executers/network'
require 'code_runner/executers/local'
require 'code_runner/executers/ruby'
require 'code_runner/executers/python'
