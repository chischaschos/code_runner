require_relative '../lib/code_runner'
require 'yaml'

describe CodeRunner do

  it 'should execute code from the fixtures' do
    Dir['spec/fixtures/*.yml'].each do |yaml_file|
      parsed_yaml = YAML::load_file yaml_file
      parsed_yaml.each do |test_case|
        results = CodeRunner.new(type: test_case['type'],
         code: test_case['code']).execute
        expect(results).to eq test_case['results']
      end
    end
  end

  it 'should support ruby, js, python and java' do
    %w(ruby js python java).each do |supported_lang|
      expect{CodeRunner.new(type: supported_lang, code: '')}.to_not raise_error
    end
    %w(erlang go what).each do |unsupported_lang|
      expect{CodeRunner.new(type: unsupported_lang, code: '')}.to raise_error
    end
  end

end
