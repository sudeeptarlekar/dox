require_relative 'framework/helper'

module Sphinx
  describe "The directive undefined_refs" do
    context 'for specifications with undefined references' do
      before(:all) do
        @test = Test.new("undefined_refs_list")
        @test.run
      end

      it 'shall generate a list of specifications including their undefined references', doc_refs: ['DoxTrace_HTML_UndefinedRefsListDirective'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("undefined_refs_list", "undefined_refs.html")

        expect(data.html).to match(/#swa_spec_1.*SWA_Spec_1.*SWA_Spec_100, BLAH, FASEL/m)
        expect(data.html).to match(/#swa_spec_2.*SWA_Spec_2.*BLAH/m)
        expect(data.html).to match(/#swa_spec_3.*SWA_Spec_3.*FASEL/m)
      end
    end

    context 'for specifications without undefined references' do
      before(:all) do
        @test = Test.new("undefined_refs_empty")
        @test.run
      end

      it 'shall generate a helper note that no undefined references exist', doc_refs: ['DoxTrace_HTML_UndefinedRefsListDirective'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("undefined_refs_empty", "undefined_refs.html")

        expect(data.html).to match(/No undefined references found./m)
      end
    end

  end
end
