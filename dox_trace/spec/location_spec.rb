require_relative 'framework/helper'

module Sphinx
  describe "The attribute location" do
    context 'with correct syntax' do
      before(:all) do
        @test = Test.new("location")
        @test.run
      end

      it 'shall be displayed correctly without any error', doc_refs: ['DoxTrace_Syntax_Location', 'DoxTrace_HTML_Location'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("location", "subfolder/index.html")

        expect(data.value("SWA_Mod_Empty", "location")).to eq '[missing]'
        expect(data.value("SWA_Mod_EmptyStruck", "location")).to eq '-'

        expect(data.value("SWA_Mod_NotExist", "location")).to eq 'modules/doesNotExist'
        expect(data.value("SWA_Mod_NotExistStruck", "location")).to eq 'modules/doesNotExist'

        expect(data.value("SWA_Mod_Exist", "location")).to eq '../modules/driver/doc/index.html'
        expect(data.value("SWA_Mod_Exist", "location", true)).to eq 'modules/driver'
      end

      it 'shall not be exported', doc_refs: ['DoxTrace_Export_Location'] do
        dim = File.read("#{$test_input_dir}/location/export_root/swa/subfolder/index.dim")
        expect(dim).not_to match(/location/)
      end

      it 'shall have correct color in HTML', doc_refs: ['DoxTrace_HTML_Location'] do
        data = HtmlData.new("location", "subfolder/index.html")

        expect(data.red?("SWA_Mod_Empty", "location")).to be false
        expect(data.red?("SWA_Mod_EmptyStruck", "location")).to be false
        expect(data.red?("SWA_Mod_NotExist", "location")).to be true
        expect(data.red?("SWA_Mod_NotExistStruck", "location")).to be false
        expect(data.red?("SWA_Mod_Exist", "location")).to be false
      end
    end

    context 'specified in an information directive' do
      before(:all) do
        @test = Test.new("location_information")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Location'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "information" directive'
        expect(@test.test_stderr).to include 'unknown option: "location"'
      end
    end

    context 'specified in an requirement directive' do
      before(:all) do
        @test = Test.new("location_requirement")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Location'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "requirement" directive'
        expect(@test.test_stderr).to include 'unknown option: "location"'
      end
    end

    context 'specified in an spec directive' do
      before(:all) do
        @test = Test.new("location_spec")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Location'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "spec" directive'
        expect(@test.test_stderr).to include 'unknown option: "location"'
      end
    end

    context 'specified in an interface directive' do
      before(:all) do
        @test = Test.new("location_interface")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Location'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "interface" directive'
        expect(@test.test_stderr).to include 'unknown option: "location"'
      end
    end

    context 'specified in an unit directive' do
      before(:all) do
        @test = Test.new("location_unit")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Location'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "unit" directive'
        expect(@test.test_stderr).to include 'unknown option: "location"'
      end
    end

    context 'specified in an srs directive' do
      before(:all) do
        @test = Test.new("location_srs")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Location'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "srs" directive'
        expect(@test.test_stderr).to include 'unknown option: "location"'
      end
    end

  end
end
