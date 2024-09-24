require_relative 'framework/helper'

module Sphinx
  describe "The attribute reuse" do
    context 'with correct syntax' do
      before(:all) do
        @test = Test.new("reuse")
        @test.run
      end

      it 'shall be loaded and displayed correctly without any error', doc_refs: ['DoxTrace_Syntax_Reuse', 'DoxTrace_HTML_Reuse'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("reuse", "index.html")

        expect(data.value("SWA_Mod_ReuseEmpty", "reuse")).to eq '-'
        expect(data.value("SWA_Mod_ReuseTrue", "reuse")).to eq 'true'
      end

      it 'shall not be exported', doc_refs: ['DoxTrace_Export_Reuse'] do
        dim = File.read("#{$test_input_dir}/reuse/export_root/swa/index.dim")
        expect(dim).not_to match(/reuse/)
      end
    end

    context 'specified in a requirement directive' do
      before(:all) do
        @test = Test.new("reuse_requirement")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Reuse'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "requirement" directive'
        expect(@test.test_stderr).to include 'unknown option: "reuse"'
      end
    end

    context 'specified in a information directive' do
      before(:all) do
        @test = Test.new("reuse_information")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Reuse'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "information" directive'
        expect(@test.test_stderr).to include 'unknown option: "reuse"'
      end
    end

    context 'specified in a spec directive' do
      before(:all) do
        @test = Test.new("reuse_spec")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Reuse'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "spec" directive'
        expect(@test.test_stderr).to include 'unknown option: "reuse"'
      end
    end

    context 'specified in a unit directive' do
      before(:all) do
        @test = Test.new("reuse_unit")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Reuse'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "unit" directive'
        expect(@test.test_stderr).to include 'unknown option: "reuse"'
      end
    end

    context 'specified in a interface directive' do
      before(:all) do
        @test = Test.new("reuse_interface")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Reuse'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "interface" directive'
        expect(@test.test_stderr).to include 'unknown option: "reuse"'
      end
    end

    context 'specified in a srs directive' do
      before(:all) do
        @test = Test.new("reuse_srs")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Reuse'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "srs" directive'
        expect(@test.test_stderr).to include 'unknown option: "reuse"'
      end
    end

  end
end
