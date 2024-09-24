require_relative 'framework/helper'

module Sphinx
  describe "The traceability report for source" do

    context 'with no data' do
      before(:all) do
        @test = Test.new("tr_source_none")
        @test.run
      end
      it 'shall display an appropriate note instead of an empty table', doc_refs: ['DoxTrace_HTML_TraceabilityReportSource'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("tr_source_none", "report.html")
        expect(data.tr_nodata?("Sources")).to be true
      end
    end

    context 'with valid data' do
      before(:all) do
        @test = Test.new("tr_source_list")
        @test.run
      end
      it 'shall contain correct data with module/value pairs including TOTAL and links', doc_refs: ['DoxTrace_HTML_TraceabilityReportSource'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("tr_source_list", "report.html")

        sources = data.tr_getSection("Sources")
        list = {}
        bullets = sources.split("<li>")[1..-1]
        bullets.each do |b|
            filtered = b.gsub(/<.*?>/, "").strip.split("\n")
            list[filtered[0]] = filtered[1].split(", ")
        end

        expect(list["index.rst"]).to match_array ["SMD_Req_deref2", "SMD_Req_deref3"]
        expect(list["second.rst"]).to match_array ["SMD_Req_deref2"]
      end
    end

  end
end
