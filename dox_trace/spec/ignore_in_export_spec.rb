require_relative 'framework/helper'

module Sphinx
  describe "The attribute ignore_in_export" do
    context 'if set' do

      before(:all) do
        @test = Test.new("ignore_in_export")
        @test.run
      end

      it 'shall disable the export of the particular specification', doc_refs: ['DoxTrace_Syntax_IgnoreInExport', 'DoxTrace_Export_IgnoreInExport'] do
        expect(@test.dim_original_data).not_to have_key("spec/test_input/ignore_in_export/export_root/srs/index.dim")
        expect(@test.dim_original_data).not_to have_key("spec/test_input/ignore_in_export/export_root/smd/index.dim")
        expect(@test.dim_original_data).to have_key("spec/test_input/ignore_in_export/export_root/swa/index.dim")

        swa = @test.dim_original_data["spec/test_input/ignore_in_export/export_root/swa/index.dim"]
        expect(swa).not_to have_key("SWA_Spec_Ignore")
        expect(swa).not_to have_key("SWA_Interface_Ignore")
        expect(swa).not_to have_key("SWA_Mod_Ignore")
        expect(swa).to have_key("SWA_Interface_NotIgnore")
      end
    end
  end
end
