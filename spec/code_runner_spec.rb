require_relative '../lib/code_runner'
require 'yaml'

describe CodeRunner do

  it "should execute code from the fixtures" do
    Dir['spec/fixtures/*.yml'].each do |yaml_file|
      parsed_yaml = YAML::load_file yaml_file
      parsed_yaml.each do |test_case|
        results = CodeRunner.execute type: test_case['ruby'],
         code: test_case['code']
        expect(results).to eq test_case['results']
      end
    end
  end
end
