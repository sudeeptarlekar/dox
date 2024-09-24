require_relative 'framework/helper'

module Sphinx
  describe "dox_trace shall" do
    context 'check for self-references' do
      before(:all) do
        @test = Test.new("check_cyclic_direct")
        @test.run
      end
      it 'and abort the build with appropriate error message if detected', doc_refs: ['DoxTrace_Checks_Cyclic'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'Found cyclic reference: SRS_Requirement_Direct -> SRS_Requirement_Direct'
      end
    end

    context 'check for cyclic references through several specifications' do
      before(:all) do
        @test = Test.new("check_cyclic_indirect")
        @test.run
      end
      it 'and abort the build with appropriate error message if detected', doc_refs: ['DoxTrace_Checks_Cyclic'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'Found cyclic reference: SRS_Requirement_Indirect1 -> SRS_Requirement_Indirect2 -> SRS_Requirement_Indirect4 -> SRS_Requirement_Indirect1'
      end
    end

    context 'check for cyclic references not through several levels' do
      before(:all) do
        @test = Test.new("check_cyclic_indirect_levels")
        @test.run
      end
      it 'and abort the build with appropriate error message if detected', doc_refs: ['DoxTrace_Checks_Cyclic'] do
        expect(@test.exit_code).to be == 0
        expect(@test.test_stderr).not_to include 'Found cyclic reference'
      end
    end

    context 'check for invalid references' do
      before(:all) do
        @test = Test.new("check_invalid_ref")
        @test.run
      end
      it 'and abort the build with appropriate error message if detected', doc_refs: ['DoxTrace_Checks_InvalidRefs'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'Found invalid reference from SRS_Requirement_InvalidRef to invalid_target'
      end
    end

    context 'check for references with wrong case' do
      before(:all) do
        @test = Test.new("check_invalid_case")
        @test.run
      end
      it 'and abort the build with appropriate error message if detected', doc_refs: ['DoxTrace_Checks_Case'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'Incorrect case in refs of SRS_Requirement_InvalidCase: SRS_Requirement_target instead of SRS_Requirement_Target'
      end
    end

    context 'check for sources in spec which do not exist' do
      before(:all) do
        @test = Test.new("check_invalid_sources_spec")
        @test.run
      end
      it 'and abort the build with appropriate error message if detected', doc_refs: ['DoxTrace_Checks_Sources'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:4: file "does/not/exist.cpp" not found'
      end
    end

    context 'check for sources in unit which do not exist' do
      before(:all) do
        @test = Test.new("check_invalid_sources_unit")
        @test.run
      end
      it 'and abort the build with appropriate error message if detected', doc_refs: ['DoxTrace_Checks_Sources'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:4: file "does/not/exist.cpp" not found'
      end
    end

    context 'check for sources in interface which do not exist' do
      before(:all) do
        @test = Test.new("check_invalid_sources_interface")
        @test.run
      end
      it 'and abort the build with appropriate error message if detected', doc_refs: ['DoxTrace_Checks_Sources'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:4: file "does/not/exist.cpp" not found'
      end
    end

    context 'check for sources in srs which do not exist' do
      before(:all) do
        @test = Test.new("check_invalid_sources_srs")
        @test.run
      end
      it 'and abort the build with appropriate error message if detected', doc_refs: ['DoxTrace_Checks_Sources'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:4: file "does/not/exist.cpp" not found'
      end
    end

    context 'not check for invalid sources in requirement' do
      before(:all) do
        @test = Test.new("check_invalid_sources_requirement")
        @test.run
      end
      it 'and not abort the build in these cases', doc_refs: ['DoxTrace_Checks_Sources'] do
        expect(@test.exit_code).to be == 0
      end
    end

    context 'check for invalid comment "spec:"' do
      before(:all) do
        @test = Test.new("check_invalid_comment_spec")
        @test.run
      end
      it 'and abort the build with appropriate error message if detected', doc_refs: ['DoxTrace_Checks_Comments'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'first line of comment looks like a typo: "spec:"'
      end
    end

    context 'check for invalid comment ":unit:"' do
      before(:all) do
        @test = Test.new("check_invalid_comment_unit")
        @test.run
      end
      it 'and abort the build with appropriate error message if detected', doc_refs: ['DoxTrace_Checks_Comments'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include ' first line of comment looks like a typo: ":unit:"'
      end
    end

    context 'check for invalid comment "interface"' do
      before(:all) do
        @test = Test.new("check_invalid_comment_interface")
        @test.run
      end
      it 'and abort the build with appropriate error message if detected', doc_refs: ['DoxTrace_Checks_Comments'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'first line of comment looks like a typo: "interface"'
      end
    end

    context 'check for invalid comment ":mod"' do
      before(:all) do
        @test = Test.new("check_invalid_comment_mod")
        @test.run
      end
      it 'and abort the build with appropriate error message if detected', doc_refs: ['DoxTrace_Checks_Comments'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'first line of comment looks like a typo: ":mod"'
      end
    end

    context 'check for invalid comment "srs.."' do
      before(:all) do
        @test = Test.new("check_invalid_comment_srs")
        @test.run
      end
      it 'and abort the build with appropriate error message if detected', doc_refs: ['DoxTrace_Checks_Comments'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'first line of comment looks like a typo: "srs.."'
      end
    end

    context 'ignore valid comments' do
      before(:all) do
        @test = Test.new("check_invalid_comment_ignored")
        @test.run
      end
      it 'and not abort the build in these cases', doc_refs: ['DoxTrace_Checks_Comments'] do
        expect(@test.exit_code).to be == 0
      end
    end

    context 'check if an ID is used twice' do
      before(:all) do
        @test = Test.new("check_unique_id")
        @test.run
      end
      it 'and abort the build with appropriate error message if detected', doc_refs: ['DoxTrace_Checks_Unique'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'specification SRS_Requirement_NotUnique found twice'
      end
    end

    context 'check if an ID contains a newline' do
      before(:all) do
        @test = Test.new("check_newline_id")
        @test.run
      end
      it 'and abort the build with appropriate error message if detected', doc_refs: ['DoxTrace_Checks_Newline'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:4: id SRS_Requirement_Direct\nContinue must not contain newlines'
      end
    end

    context 'check if an ID has two underscores after the prefix instead of one' do
      before(:all) do
        @test = Test.new("check_naming_double_underscore")
        @test.run
      end
      it 'and abort the build with appropriate error message if detected', doc_refs: ['DoxTrace_Checks_Naming'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:4: id SWA__ does not follow the form SMD|SWA_<string>_<string>'
      end
    end

    context 'check if an ID has incorrect case' do
      before(:all) do
        @test = Test.new("check_naming_lower_case")
        @test.run
      end
      it 'and abort the build with appropriate error message if detected', doc_refs: ['DoxTrace_Checks_Naming'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:4: id swa_x_y does not follow the form SMD|SWA_<string>_<string>'
      end
    end

    context 'check if an ID does not have a character after the first underscore' do
      before(:all) do
        @test = Test.new("check_naming_too_short")
        @test.run
      end
      it 'and abort the build with appropriate error message if detected', doc_refs: ['DoxTrace_Checks_Naming'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:4: id SMD_ModuleName_ does not follow the form SMD_<string>_<string>'
      end
    end

    context 'check if a deprecated ID does not have a character after the first underscore' do
      before(:all) do
        @test = Test.new("check_naming_too_short_deprecated")
        @test.run
      end
      it 'and abort the build with appropriate error message if detected', doc_refs: ['DoxTrace_Checks_NamingDeprecated'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:4: id SMD_ does not follow the form SMD|SWA_<string>_<string>'
      end
    end

    context 'check if spec ID does not contain three underscores' do
      before(:all) do
        @test = Test.new("check_naming_three_underscores")
        @test.run
      end
      it 'and abort the build with appropriate error message if detected', doc_refs: ['DoxTrace_Checks_Naming'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:4: id SWA_X_Y_Z does not follow the form SMD|SWA_<string>_<string>'
      end
    end

    context 'check if an interface ID does not start with wrong prefix' do
      before(:all) do
        @test = Test.new("check_naming_wrong_prefix_interface")
        @test.run
      end
      it 'and abort the build with appropriate error message if detected', doc_refs: ['DoxTrace_Checks_Naming'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:4: id SMD_X_Y does not follow the form SWA_<string>_<string>'
      end
    end

    context 'check if a mod ID does not start with wrong prefix' do
      before(:all) do
        @test = Test.new("check_naming_wrong_prefix_mod")
        @test.run
      end
      it 'and abort the build with appropriate error message if detected', doc_refs: ['DoxTrace_Checks_Naming'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:4: id SMD_X_Y does not follow the form SWA_<string>_<string>'
      end
    end

    context 'check if an srs ID does not start with wrong prefix' do
      before(:all) do
        @test = Test.new("check_naming_wrong_prefix_srs")
        @test.run
      end
      it 'and abort the build with appropriate error message if detected', doc_refs: ['DoxTrace_Checks_Naming'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:4: id SWA_X_Y does not follow the form SRS_<string>_<string>'
      end
    end

    context 'check if a unit ID does not start with wrong prefix' do
      before(:all) do
        @test = Test.new("check_naming_wrong_prefix_unit")
        @test.run
      end
      it 'and abort the build with appropriate error message if detected', doc_refs: ['DoxTrace_Checks_Naming'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:4: id SWA_X_Y does not follow the form SMD_<string>_<string>'
      end
    end

    context 'check if a deprecated ID does not start with wrong prefix' do
      before(:all) do
        @test = Test.new("check_naming_wrong_prefix_tolerant")
        @test.run
      end
      it 'and abort the build with appropriate error message if detected', doc_refs: ['DoxTrace_Checks_NamingDeprecated'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:4: id SRS_X does not follow the form SMD_<string>'
      end
    end

    context 'accept valid IDs' do
      before(:all) do
        @test = Test.new("check_naming_valid")
        @test.run
      end
      it 'and not abort the build in these cases', doc_refs: ['DoxTrace_Checks_Naming'] do
        expect(@test.exit_code).to be == 0
      end
    end

    context 'accept valid deprecated IDs' do
      before(:all) do
        @test = Test.new("check_naming_valid_tolerant")
        @test.run
      end
      it 'and not abort the build in these cases', doc_refs: ['DoxTrace_Checks_NamingDeprecated'] do
        expect(@test.exit_code).to be == 0
      end
    end

    context 'check if Python 3.8 or later is used' do
      before(:all) do
        # every test setup can be used which has to error
        @test = Test.new("check_outdated_python", "MANIPULATE_PYTHON_VERSION=1")
        @test.run
      end
      it 'and abort the build with appropriate error message if Python version is too old', doc_refs: ['DoxTrace_Checks_PythonVersion'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'The dox_trace extension requires Python 3.8+'
      end
    end

    context 'check if Sphinx 6.2 or later is used' do
      before(:all) do
        # every test setup can be used which has to error
        @test = Test.new("check_outdated_sphinx", "MANIPULATE_SPHINX_VERSION=1")
        @test.run
      end
      it 'and abort the build with appropriate error message if Sphinx version is too old', doc_refs: ['DoxTrace_Checks_SphinxVersion'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'The dox_trace extension requires Sphinx 6.2+'
      end
    end
  end
end
