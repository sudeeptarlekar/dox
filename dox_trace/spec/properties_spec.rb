require_relative 'framework/helper'

module Sphinx
  describe "Properties file" do
    context 'values shall be used' do
      before(:all) do
        @test = Test.new("properties")
        @test.run
      end

      it 'for non-set attributes if the ID is specified with full name', doc_refs: ['dox_trace_properties_file', 'DoxTrace_Properties_Use'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("properties", "index.html")
        expect(data.value("SRS_Requirement1_Full", "asil")).to eq 'ASIL_A'
        expect(data.value("SRS_Requirement1_Full", "content")).to eq '<p>Single line</p>'
      end

      it 'for non-set attributes if the ID is specified with module name', doc_refs: ['dox_trace_properties_file', 'DoxTrace_Properties_Use'] do
        data = HtmlData.new("properties", "index.html")
        expect(data.value("SRS_Requirement2_Mod", "asil")).to eq 'ASIL_C'
        expect(data.value("SRS_Requirement2_Mod", "content")).to match /Multi.*<li>.*line1.*<li>.*<strong>line2<\/strong>/m
      end

      it 'for non-set attributes if the ID is specified with category name', doc_refs: ['dox_trace_properties_file', 'DoxTrace_Properties_Use'] do
        data = HtmlData.new("properties", "index.html")
        expect(data.value("SWA_Custom_CategorySet", "developer")).to eq 'Abc AG'
        expect(data.value("SMD_Custom_CategoryNotSet", "developer")).to eq '[missing]'
      end

      it 'for non-set attributes if _default_ is specified', doc_refs: ['dox_trace_properties_file', 'DoxTrace_Properties_Use'] do
        data = HtmlData.new("properties", "index.html")
        expect(data.value("SRS_Requirement3_Default", "asil")).to eq 'QM'
        expect(data.value("NoModuleNameDefault", "asil")).to eq 'QM'
        expect(data.value("SRS_Requirement3_Default", "content")).to eq '<p>Todo</p>'
        expect(data.value("NoModuleNameDefault", "content")).to eq '<p>Todo</p>'
      end

      it 'unless attributes are already specified', doc_refs: ['dox_trace_properties_file', 'DoxTrace_Properties_Use'] do
        data = HtmlData.new("properties", "index.html")
        expect(data.value("SRS_Requirement4_Defined", "asil")).to eq 'ASIL_D'
        expect(data.value("SRS_Requirement4_Defined", "content")).to eq '<p>Original content.</p>'
      end

      it 'also for custom attributes', doc_refs: ['dox_trace_properties_file', 'DoxTrace_Properties_Custom'] do
        data = HtmlData.new("properties", "index.html")
        expect(data.value("SMD_Custom_Prop", "asil")).to eq 'ASIL_D'
        expect(data.value("SMD_Custom_Overwritten", "asil")).to eq 'ASIL_C'
      end

      it 'for standalone roles and directives', doc_refs: ['DoxTrace_Properties_Standalone'] do
        raw = HtmlData.new("properties", "index.html").html
        expect(raw).to match /Role defined.*literal.*Single.*line/
        expect(raw).to match /Directive defined.*line1.*line2.*Role default/m
        expect(raw).to match /Role default.*literal.*Todo/
        expect(raw).to match /Directive default[^\n]*\n[^\n]*Todo/m
      end

      it 'as string even they are defined as boolean in YAML', doc_refs: ['DoxTrace_Properties_Use'] do
        data = HtmlData.new("properties", "index.html")
        expect(data.value("SWA_Custom_True", "tags")).to eq 'true'
        expect(data.value("SWA_Custom_False", "tags")).to eq 'false'
      end
    end

    context 'not exist' do
      before(:all) do
        @test = Test.new("properties_no_file")
        @test.run
      end

      it 'shall abort the the build aborted with an appropriate error message', doc_refs: ['dox_trace_properties_file'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'properties.yaml does not exist'
      end
    end

    context 'not specified but used' do
      before(:all) do
        @test = Test.new("properties_not_available")
        @test.run
      end

      it 'shall abort the the build aborted with an appropriate error message', doc_refs: ['dox_trace_properties_file'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:21: dox_trace_properties_file not specified in configuration'
      end
    end

    context 'with invalid syntax' do
      before(:all) do
        @test = Test.new("properties_wrong_file")
        @test.run
      end

      it 'shall abort the the build aborted with an appropriate error message', doc_refs: ['dox_trace_properties_file'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:21: property bla:fasel not found'
      end
    end

    context 'with attribute name not found' do
      before(:all) do
        @test = Test.new("properties_no_name")
        @test.run
      end

      it 'shall abort the the build aborted with an appropriate error message', doc_refs: ['DoxTrace_Properties_Use'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:21: property nope:fasel not found'
      end
    end

    context 'with attribute value not found' do
      before(:all) do
        @test = Test.new("properties_no_value")
        @test.run
      end

      it 'shall abort the the build aborted with an appropriate error message', doc_refs: ['DoxTrace_Properties_Use'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:21: property bla:nope not found'
      end
    end

    context 'value used without colon' do
      before(:all) do
        @test = Test.new("properties_wrong_syntax")
        @test.run
      end

      it 'shall abort the the build aborted with an appropriate error message', doc_refs: ['DoxTrace_Properties_Use'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:4: property no_colon does not include exactly one ":"'
      end
    end

  end
end
