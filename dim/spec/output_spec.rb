require_relative 'framework/helper'

module Dim
  class TestThreadOut
    def flush
      puts 'test123'
    end
  end

  describe 'Dim output' do
    context 'using string streams' do
      t = ThreadOut.new('test', 'test')
      it 'shall not lead to exceptions if a pipe is broken', doc_refs: ['Dim_testing_output'] do
        expect { t.flush }.not_to raise_error
      end
      it 'shall be readable by unit tests', doc_refs: ['Dim_testing_output'] do
        s = TestThreadOut.new
        Thread.current['test'] = s
        expect { t.flush }.not_to raise_error
        expect(@test_stdout).to include('test123')
      end
    end
  end
end
