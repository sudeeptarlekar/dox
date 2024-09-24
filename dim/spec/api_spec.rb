require_relative 'framework/helper'

module Dim
  describe 'Dim API' do
    before { loader.load(file: filepath, allow_missing: allow_missing) }

    let(:loader) { Dim::Loader.new }
    let(:allow_missing) { false }
    let(:filepath) { "#{TEST_INPUT_DIR}/resolved_function_temp/config.dim" }

    context 'in general shall' do
      FileUtils.rm_rf("#{TEST_INPUT_DIR}/resolved_function_temp")
      FileUtils.cp_r("#{TEST_INPUT_DIR}/resolved_function", "#{TEST_INPUT_DIR}/resolved_function_temp")
      let(:filepath) { "#{TEST_INPUT_DIR}/resolved_function_temp/config.dim" }

      it 'provide access to resolved attributes', doc_refs: ['Dim_api_reading'] do
        req = loader.requirements['RESOLVE_003']
        expect(req.verification_methods).to match_array(['none'])
      end

      it 'provide access to original attributes', doc_refs: ['Dim_api_changing'] do
        req = loader.original_data["#{TEST_INPUT_DIR}/resolved_function_temp/modules/Module1.dim"]['RESOLVE_003']
        expect(req['verification_methods']).to be nil
      end

      it 'provide functionality to write data back to requirements files', doc_refs: ['Dim_api_changing'] do
        req = loader.original_data["#{TEST_INPUT_DIR}/resolved_function_temp/modules/Module1.dim"]['RESOLVE_003']
        req['verification_methods'] = 'manual'
        req['comment'] = ''
        formatter2 = Dim::Format.new(loader)
        formatter2.execute
        loader2 = Dim::Loader.new
        loader2.load(file: "#{TEST_INPUT_DIR}/resolved_function_temp/config.dim")
        req2 = loader2.requirements['RESOLVE_003']
        expect(req2.verification_methods).to match_array('manual')
        expect(req2.comment).to eq ''
      end
    end

    context 'shall provide convenience method' do
      # let(:filepath) { "#{TEST_INPUT_DIR}/convenience/module_ok.dim" }

      context 'safety and cal relevant' do
        let(:filepath) { "#{TEST_INPUT_DIR}/relevant/module_ok.dim" }

        it 'safety_relevant?', doc_refs: ['Dim_api_safetyRelevant'] do
          loader.requirements.each do |id, r|
            expect(r.safety_relevant?).to be id.include?('safe')
          end
        end

        it 'security_relevant?', doc_refs: ['Dim_api_securityRelevant'] do
          loader.requirements.each do |id, r|
            expect(r.security_relevant?).to be id.include?('cal')
          end
        end
      end
    end

    context 'shall provide getter method' do
      before { loader_config.load(file: "#{TEST_INPUT_DIR}/resolved_function/config.dim") }

      let(:allow_missing) { true }
      let(:filepath) { "#{TEST_INPUT_DIR}/resolved_function/modules/Module1.dim" }
      let(:first_req) { loader.requirements['RESOLVE_001'] }
      let(:third_req) { loader.requirements['RESOLVE_003'] }
      let(:loader_config) { Dim::Loader.new }
      let(:first_req_config) { loader_config.requirements[first_req.id] }
      let(:line_number) { Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('2.4') ? 3 : nil }

      it 'document name', doc_refs: ['Dim_api_documentName'] do
        expect(first_req.category).to eql('unspecified')
      end

      it 'origin, loaded directly', doc_refs: ['Dim_api_originator'] do
        expect(first_req.origin).to eql('')
      end

      it 'origin, loaded via config file', doc_refs: ['Dim_api_originator'] do
        expect(first_req_config.origin).to eql('Customer')
      end

      it 'existingRefs', doc_refs: ['Dim_api_existingRefs'] do
        expect(first_req.existingRefs).to eq ['RESOLVE_003']
      end

      it 'category, loaded directly', doc_refs: ['Dim_api_category'] do
        expect(first_req.category).to eql('unspecified')
      end

      it 'category, loaded via config file', doc_refs: ['Dim_api_category'] do
        expect(first_req_config.category).to eql('input')
      end

      it 'filename', doc_refs: ['Dim_api_filename'] do
        expect(first_req.filename).to eql('spec/test_input/resolved_function/modules/Module1.dim')
      end

      it 'line_number', doc_refs: ['Dim_api_lineNumber'] do
        expect(first_req.line_number).to eq line_number
      end

      it 'backwardRefs', doc_refs: ['Dim_api_backwardRefs'] do
        expect(third_req.backwardRefs).to eq ['RESOLVE_001']
      end
    end

    context 'shall provide convenient string method' do
      it 'cleanSplit', doc_refs: ['Dim_api_stringCleanSplit'] do
        expect('a,a,b    ,,  c'.cleanSplit).to eq ['a', 'a', 'b', '', 'c']
        expect(''.cleanSplit).to eq []
      end

      it 'cleanArray', doc_refs: ['Dim_api_stringCleanArray'] do
        expect('a,a,b    ,,  c'.cleanArray).to eq %w[a a b c]
        expect(''.cleanArray).to eq []
      end

      it 'cleanUniqArray', doc_refs: ['Dim_api_stringCleanUniqArray'] do
        expect('a,a,b    ,,  c'.cleanUniqArray).to eq %w[a b c]
        expect(''.cleanUniqArray).to eq []
      end

      it 'cleanString', doc_refs: ['Dim_api_stringCleanString'] do
        expect('a,a,b    ,,  c'.cleanString).to eq('a, a, b, c')
        expect(''.cleanString).to eq('')
      end

      it 'cleanUniqString', doc_refs: ['Dim_api_stringCleanUniqString'] do
        expect('a,a,b    ,,  c'.cleanUniqString).to eq('a, b, c')
        expect(''.cleanUniqString).to eq('')
      end

      it 'addEnum', doc_refs: ['Dim_api_stringAddEnum'] do
        expect('REFS_R1, REFS_R2'.addEnum('xy')).to eq('REFS_R1, REFS_R2, xy')
        expect('REFS_R1, REFS_R2, xy'.addEnum('REFS_R1')).to eq('REFS_R1, REFS_R2, xy')
        expect(''.addEnum('abc')).to eq('abc')
      end

      it 'removeEnum', doc_refs: ['Dim_api_stringRemoveEnum'] do
        expect('REFS_R1, REFS_R2, xy'.removeEnum('REFS_R1')).to eq('REFS_R2, xy')
        expect('REFS_R2, xy'.removeEnum('xy').removeEnum('xy')).to eq('REFS_R2')
        expect('REFS_R2'.removeEnum('REFS_R2').removeEnum('REFS_R2')).to eq('')
      end
    end

    context 'access to non-existing attribute', doc_refs: ['Dim_api_reading'] do
      let(:filepath) { "#{TEST_INPUT_DIR}/language/module_ok.dim" }

      it 'shall abort and print a meaningful error message' do
        expect { loader.requirements['ESR_Test_1'].doesNotExist }.to raise_exception(SystemExit)
        expect(Dim::ExitHelper.exit_code).to eq 1
        expect(@test_stderr).to include 'Error: "doesNotExist" is not a requirement attribute'
      end
    end

    context 'shall provide a loading-function,' do
      it 'which loads the file when arguments are valid', doc_refs: ['Dim_api_reading'] do
        # array length 1, string argument not used
        loader = Dim::Loader.new
        loader.load(input_filenames: ["#{TEST_INPUT_DIR}/reqs/text/default.dim"], silent: false)
        expect(Dim::ExitHelper.exit_code).to eq 0
        expect(@test_stdout).to include 'Loading [unknown] spec/test_input/reqs/text/default.dim...'

        # array argument has string type, string argument not used
        loader = Dim::Loader.new
        loader.load(input_filenames: "#{TEST_INPUT_DIR}/reqs/text/default.dim", silent: false)
        expect(Dim::ExitHelper.exit_code).to eq 0
        expect(@test_stdout).to include 'Loading [unknown] spec/test_input/reqs/text/default.dim...'

        # array is empty, string argument used
        loader = Dim::Loader.new
        loader.load(file: "#{TEST_INPUT_DIR}/reqs/text/default.dim", silent: false)
        expect(Dim::ExitHelper.exit_code).to eq 0
        expect(@test_stdout).to include 'Loading [unknown] spec/test_input/reqs/text/default.dim...'
      end

      it 'which throws an error with a meaningful error message if arguments are invalid',
         doc_refs: ['Dim_api_reading'] do
        # both arguments are used at the same time
        loader = Dim::Loader.new
        expect { loader.load(file: 'abc', input_filenames: 'abc') }.to raise_exception(SystemExit)
        expect(Dim::ExitHelper.exit_code).to eq 1
        expect(@test_stderr).to include 'use either file or input_filenames argument (deprecated) for load method'

        # no argument used
        loader = Dim::Loader.new
        expect { loader.load }.to raise_exception(SystemExit)
        expect(Dim::ExitHelper.exit_code).to be 1
        expect(@test_stderr).to include 'neither file nor input_filenames argument (deprecated) ' \
                                          'argument specified for load method'

        # array length > 1
        loader = Dim::Loader.new
        expect { loader.load(input_filenames: %w[abc def]) }.to raise_exception(SystemExit)
        expect(Dim::ExitHelper.exit_code).to eq 1
        expect(@test_stderr).to include 'input_filenames argument (deprecated) of load method must have at maximum one entry'
      end
    end

    context 'shall provide the metadata of the modules,' do
      let(:filepath) { "#{TEST_INPUT_DIR}/metadata/meta.dim" }
      let(:r) { loader.requirements['SRS_X_Y'] }

      it 'as key/value pair', doc_refs: ['Dim_api_metadata'] do
        expect(loader.metadata[r.document]).to eq('Test Meta')
        expect(loader.original_data[r.filename]['metadata']).to eq('Test Meta')
      end
    end
  end
end
