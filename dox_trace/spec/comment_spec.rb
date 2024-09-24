require_relative 'framework/helper'

module Sphinx
  describe "The attribute comment" do
    context 'with correct syntax' do
      before(:all) do
        @test = Test.new("comment")
        @test.run
      end

      it 'shall be loaded and displayed correctly without any error', doc_refs: ['DoxTrace_Syntax_Comment', 'DoxTrace_HTML_Comment'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("comment", "index.html")

        expect(data.exist?("SRS_Information_CommentSet", "comment")).to be false
        expect(data.exist?("SRS_Requirement_CommentSet", "comment")).to be false
        expect(data.value("InputInformation_CommentSet", "comment")).to eq 'Cc'
        expect(data.value("InputRequirement_CommentSet", "comment")).to eq 'Dd'

        expect(data.exist?("SRS_Information_CommentDefault", "comment")).to be false
        expect(data.exist?("SRS_Requirement_CommentDefault", "comment")).to be false
        expect(data.value("InputInformation_CommentDefault", "comment")).to eq '-'
        expect(data.value("InputRequirement_CommentDefault", "comment")).to eq '-'
      end
    end

    context 'specified in a spec directive' do
      before(:all) do
        @test = Test.new("comment_spec")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Comment'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "spec" directive'
        expect(@test.test_stderr).to include 'unknown option: "comment"'
      end
    end

    context 'specified in a unit directive' do
      before(:all) do
        @test = Test.new("comment_unit")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Comment'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "unit" directive'
        expect(@test.test_stderr).to include 'unknown option: "comment"'
      end
    end

    context 'specified in an interface directive' do
      before(:all) do
        @test = Test.new("comment_interface")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Comment'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "interface" directive'
        expect(@test.test_stderr).to include 'unknown option: "comment"'
      end
    end

    context 'specified in an mod directive' do
      before(:all) do
        @test = Test.new("comment_mod")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Comment'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "mod" directive'
        expect(@test.test_stderr).to include 'unknown option: "comment"'
      end
    end

    context 'specified in an srs directive' do
      before(:all) do
        @test = Test.new("comment_srs")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Comment'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "srs" directive'
        expect(@test.test_stderr).to include 'unknown option: "comment"'
      end
    end

  end
end
