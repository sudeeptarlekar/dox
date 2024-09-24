require_relative 'framework/helper'

module Dim
  describe 'dim stats' do
    context '-i <single requirements file>' do
      it 'shall print detailed statistics of the module', doc_refs: ['Dim_stats_Details'] do
        Test.main("stats -i #{TEST_INPUT_DIR}/stats_input/test_module_1.dim")
        expect(@test_stdout).to include 'DOCUMENT: test_module_1'
        expect(@test_stdout).to include 'Number of files: 1'
        expect(@test_stdout).to include 'Number of entries: 9'
        expect(@test_stdout).to include 'Requirements: 9'
        expect(@test_stdout).to include 'Valid requirements: 8'
        expect(@test_stdout).to include '  Accepted: 5'
        expect(@test_stdout).to include '    Covered: 4'
        expect(@test_stdout).to include '    Not covered: 1'
        expect(@test_stdout).to include '  Rejected: 1'
        expect(@test_stdout).to include '  Unclear: 1'
        expect(@test_stdout).to include '  Not reviewed: 1'
      end
    end

    context '-i <config file>' do
      it 'shall print statistics of all modules and a summary',
         doc_refs: %w[Dim_stats_General Dim_loading_readGood] do
        Test.main("stats -i #{TEST_INPUT_DIR}/stats_input/Config.dim")
        expect(@test_stdout).to include 'ALL'
        expect(@test_stdout).to include 'DOCUMENT: test_module_1'
        expect(@test_stdout).to include 'DOCUMENT: test_module_2'
        expect(@test_stdout).to include 'Requirements: 11'
        expect(@test_stdout).to include 'Requirements: 9'
        expect(@test_stdout).to include 'Requirements: 2'
      end
    end
  end
end
