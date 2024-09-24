require_relative 'framework/helper'
require 'fileutils'

module Sphinx
  describe "dox_trace shall support" do
    context 'single-threaded build' do
      before(:all) do
        @test = Test.new("parallel")
        @test.run
      end

      it 'on all platforms',
        doc_refs: ['DoxTrace_Build_Single'] do
        expect(@test.exit_code).to be == 0
        data_main = HtmlData.new("parallel", "index.html")
        data_subpage = HtmlData.new("parallel", "subpage1.html")

        expect(data_main.value("SWA_Spec_Main", "Downstream References")).to eq 'subpage1.html#swa_spec_subpage1, subpage2.html#swa_spec_subpage2'
        expect(data_subpage.value("SWA_Spec_Subpage1", "Downstream References")).to eq 'subpage2.html#swa_spec_subpage2'
      end
    end

    context 'parallel build' do
      before(:all) do
        FileUtils.rm_rf("spec/test_input/parallel/build")
        # MANIPULATE_DOXTRACE_PARALLEL=1 forces some code to be executed on non-posix platforms
        # to get 100% code coverage. A real parallel-test is only done on posix platforms.
        @test = Test.new("parallel", "SPHINXOPTS=\"-j auto\" MANIPULATE_DOXTRACE_PARALLEL=1")
        @test.run
      end

      it 'on all platforms',
        doc_refs: ['DoxTrace_Build_Multi'] do
        expect(@test.exit_code).to be == 0
        data_main = HtmlData.new("parallel", "index.html")
        data_subpage = HtmlData.new("parallel", "subpage1.html")
        dim_main = @test.dim_original_data["spec/test_input/parallel/export_root/swa/index.dim"]

        expect(data_main.value("SWA_Spec_Main", "Downstream References")).to eq 'subpage1.html#swa_spec_subpage1, subpage2.html#swa_spec_subpage2'
        expect(data_subpage.value("SWA_Spec_Subpage1", "Downstream References")).to eq 'subpage2.html#swa_spec_subpage2'

        expect(dim_main["SWA_Spec_Main"]["tester"]).to eq 'Parallel = True'
      end
    end

  end
end
