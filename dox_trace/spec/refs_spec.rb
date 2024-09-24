require_relative 'framework/helper'

module Sphinx
  describe "The attribute refs" do

    context 'specified in an mod directive' do
      before(:all) do
        @test = Test.new("refs_mod")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an error message', doc_refs: ['DoxTrace_Syntax_Refs'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include 'index.rst:7:Error in "mod" directive'
        expect(@test.test_stderr).to include 'unknown option: "refs"'
      end
    end

    context 'including an undefined target building with dox_trace_allow_undefined_refs=False' do
      before(:all) do
        @test = Test.new("refs_undefined_warn")
        @test.run
      end

      it 'shall cause dox_trace to abort with exit code != 0 and print an warning message', doc_refs: ['DoxTrace_HTML_RefsRed'] do
        expect(@test.exit_code).to be > 0
        expect(@test.test_stderr).to include "SWA_Spec_1 refers to non-existing SWA_Spec_100"
      end
    end

    context 'including undefined targets building with dox_trace_allow_undefined_refs=True' do
      before(:all) do
        @test = Test.new("refs_undefined_nowarn")
        @test.run
      end

      it 'shall NOT cause dox_trace to abort with exit code != 0 and NOT print a warning message', doc_refs: ['DoxTrace_HTML_RefsRed'] do
        expect(@test.exit_code).to be == 0
        expect(@test.test_stderr).not_to include "SWA_Spec_1 refers to non-existing SWA_Spec_100"
      end

      it 'shall display defined targets as links', doc_refs: ['DoxTrace_HTML_UpstreamRefs', 'DoxTrace_HTML_DownstreamRefs', 'DoxTrace_HTML_RefsRed'] do

        data = HtmlData.new("refs_undefined_nowarn", "index.html")

        expect(data.value("SWA_Spec_1", "Downstream References")).to eq '#swa_spec_2, #swa_spec_3'
        expect(data.value("SWA_Spec_2", "Downstream References")).to eq '#swa_spec_3'
        expect(data.value("SWA_Spec_3", "Downstream References")).to eq 'FASEL' # neither "#" nor "[missing]"
      end

      it 'shall display undefined targets in red', doc_refs: ['DoxTrace_HTML_RefsRed'] do
        expect(@test.exit_code).to be == 0
        expect(@test.test_stderr).not_to include "SWA_Spec_1 refers to non-existing SWA_Spec_100"

        data = HtmlData.new("refs_undefined_nowarn", "index.html")

        refs = {"SWA_Spec_1" => ["SWA_Spec_100", "BLAH", "#swa_spec_2", "FASEL", "#swa_spec_3"],
                "SWA_Spec_2" => ["#swa_spec_3", "BLAH"],
                "SWA_Spec_3" => ["FASEL"]}

        refs.each do |source, targets|
          line = data.as_is_line(source, "Downstream References")
          targets.each do |id|
            if id.include?"#"
              expect(line).to match(/<a.*#{id}.*<\/a>/)
            else
              expect(line).to match(/<span class="dox-trace-red">#{id}<\/span>/)
            end
            num_of_red = targets.count{|id| !id.include?"#"}
            expect(line).to match(/"(dox-trace-red.*"){#{num_of_red}}/)
          end
        end
      end

      it 'shall not export unresolved references', doc_refs: ['DoxTrace_HTML_RefsExport'] do
        data = @test.dim_original_data["spec/test_input/refs_undefined_nowarn/export_root/swa/index.dim"]

        expect(data["SWA_Spec_1"]["refs"]).to eq 'SWA_Spec_2, SWA_Spec_3'
        expect(data["SWA_Spec_2"]["refs"]).to eq 'SWA_Spec_3'
        expect(data["SWA_Spec_3"]["refs"]).to eq ''
      end
    end

  end
end
