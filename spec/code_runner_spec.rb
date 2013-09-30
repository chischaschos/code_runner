require_relative '../lib/code_runner'
require 'yaml'

describe CodeRunner do

  before { CodeRunner.executer = CodeRunner::Executers::Local.new }

  it 'should execute code from the fixtures' do
    Dir['spec/fixtures/*.yml'].each do |yaml_file|
      parsed_yaml = YAML::load_file yaml_file

      test_type = yaml_file.match(/(\w+)\.yml$/)[1]

      parsed_yaml.each do |test_case|
        code = File.open("spec/fixtures/#{test_case['code']}").readlines.join
        results = CodeRunner.execute type: test_type, code: code
        expect(results).to eq test_case['results']
      end

    end
  end

  it 'should support ruby, js, python and java' do
    %w(ruby).each do |supported_lang|
      expect{CodeRunner.execute(type: supported_lang, code: '')}.to_not raise_error
    end

    %w(erlang go what).each do |unsupported_lang|
      expect{CodeRunner.execute(type: unsupported_lang, code: '')}.to raise_error
    end
  end

end
