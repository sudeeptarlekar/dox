    require_relative 'framework/helper'

module Sphinx
  describe "The directive enclosed" do

    context 'shall copy files to build folder' do
      before(:all) do
        @test = Test.new("enclosed")
        @test.run
      end

      it 'listed in the content of the directive', doc_refs: [ 'DoxTrace_HTML_EnclosedDirective'] do
        expect(@test.exit_code).to be == 0

        expect(File.exist?("spec/test_input/enclosed/build/html/a.txt")).to be true
        expect(File.exist?("spec/test_input/enclosed/build/html/b/b.txt")).to be true
        expect(File.exist?("spec/test_input/enclosed/build/html/c.txt")).to be true
      end
    end

    context 'shall warn if a file listed in the content of the directive' do
      before(:all) do
        @test = Test.new("enclosed_invalid")
        @test.run
      end

      it 'does not exist', doc_refs: [ 'DoxTrace_HTML_EnclosedDirective'] do
        expect(@test.exit_code).to be > 0

        expect(@test.test_stderr).to include 'index.rst:8: file "d.txt" does not exist'
      end
    end

  end
end
