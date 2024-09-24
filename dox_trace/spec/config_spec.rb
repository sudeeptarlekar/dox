    require_relative 'framework/helper'

module Sphinx
  describe "The directive" do
    context 'dox_trace_config' do
      before(:all) do
        @test = Test.new("config")
        @test.run
      end

      attributes = ["Status", "Review Status",
                    "Asil", "Security", "Developer", "Tester", "Test Setups", "Tags",
                    "Reuse", "Usage",
                    "Verification Criteria",
                    "Comment",
                    "Feature",
                    "Change Request",
                    "Miscellaneous",
                    "Upstream Asil", "Upstream Security", "Upstream Tags", "Derived Feature", "Derived Change Request",
                    "Location", "Sources", "Upstream References", "Downstream References"]


      it 'shall be used to hide/show complete attribute rows', doc_refs: [ 'DoxTrace_HTML_ConfigReadingMode'] do
        expect(@test.exit_code).to be == 0
        data = HtmlData.new("config", "index.html")

        html = data.html
        html.gsub!(/<tr class="row-even"><td><p>\s*\[missing\]\s*<\/p><\/td><\/tr>/m, "") # content
        html.gsub!(/<tr class="row-even" hidden\/>/, "") # hidden rows
        html.gsub!(/<tr class="row-odd dox-trace-attribute.*?<\/tr>/m, "") # complete rows
        html.gsub!(/dox-trace-attribute.*?(<br>|<p>|<\/p>)/m, "") # attributes from first row

        # attributes hidden
        attributes.each do |attribute|
          if html.include?("<strong>#{attribute}:</strong>")
            puts "FOUND: #{attribute}"
          end
          expect(html).not_to include("<strong>#{attribute}:</strong>")
        end
      end

      # this is a test if jQuery and localStorage are used in general, it will
      # not replace a manual test and review in real browsers
      it 'shall expand to a configuration table using jQuery and the local storage of the browser',
        doc_refs: ['DoxTrace_HTML_ConfigDirective', 'DoxTrace_HTML_ConfigStorage'] do

        data = HtmlData.new("config", "index.html")
        js = File.read("#{$test_input_dir}/config/build/html/_static/dox_trace.js")
        expect(data.html).to match(/_static\/dox_trace.css/)

        # id used in jQuery
        ["dox_trace_config_none", "dox_trace_config_empty", "dox_trace_config_missing", "dox_trace_config_all"].each do |id|
            expect(data.html).to match(/id="#{id}"/)
            expect(js).to match(/##{id}/)
        end

        # local storage based on project name
        expect(js).to match(/name="dox_trace_storage"/)
        expect(data.html).to match(/<meta content="TestProject" name="dox_trace_storage" \/>/)
      end

      it 'shall be used to hide/show empty/missing attributes', doc_refs: [ 'DoxTrace_HTML_ConfigReadingMode'] do
        data_index = HtmlData.new("config", "index.html")
        data_filled = HtmlData.new("config", "filled.html")
        data_special = HtmlData.new("config", "special.html")

        expected = {
          "Input_ConfigPreview_Requirement" => {:empty   => ["verification_methods", "tags", "verification_criteria", "comment", "miscellaneous", "feature", "change_request", "upstream_references", "custom"],
                                                :missing => ["developer", "tester", "downstream_references"]},
          "Input_ConfigPreview_Information" => {:empty   => ["tags", "comment", "miscellaneous", "downstream_references", "upstream_references", "custom"],
                                                :missing => []},
          "SRS_ConfigPreview_Requirement" =>   {:empty   => ["verification_methods", "tags", "derived_feature", "derived_change_request", "upstream_asil", "upstream_security", "upstream_tags", "custom"],
                                                :missing => ["developer", "tester", "verification_criteria", "downstream_references", "upstream_references"]},
          "SRS_ConfigPreview_Information" =>   {:empty   => ["tags", "upstream_asil", "upstream_security", "upstream_tags", "downstream_references", "upstream_references", "custom"],
                                                :missing => []},
          "SRS_ConfigPreview_Srs" =>           {:empty   => ["tags", "derived_feature", "derived_change_request", "upstream_asil", "upstream_security", "upstream_tags", "custom"],
                                                :missing => ["verification_criteria", "downstream_references", "upstream_references", "developer", "tester"]},
          "SWA_ConfigPreview_Spec" =>          {:empty   => ["tags", "derived_feature", "derived_change_request", "upstream_asil", "upstream_security", "upstream_tags", "verification_criteria", "custom"],
                                                :missing => ["downstream_references", "upstream_references", "developer", "tester"]},
          "SWA_ConfigPreview_Mod" =>           {:empty   => ["reuse", "usage", "upstream_asil", "upstream_security", "custom"],
                                                :missing => ["developer", "location", "upstream_references", "developer"]},
          "SWA_ConfigPreview_Interface" =>     {:empty   => ["tags", "verification_criteria", "derived_feature", "derived_change_request", "upstream_asil", "upstream_security", "upstream_tags", "custom"],
                                                :missing => ["downstream_references", "upstream_references", "developer", "tester"]},
          "SMD_ConfigPreview_Unit" =>          {:empty   => ["tags", "verification_criteria", "derived_feature", "derived_change_request", "upstream_asil", "upstream_security", "upstream_tags", "downstream_references", "custom"],
                                                :missing => ["sources", "upstream_references", "developer", "tester"]},
          "Input_ConfigPreview_RequirementFilled" => {:empty => [],:missing => []},
          "Input_ConfigPreview_InformationFilled" => {:empty => [],:missing => []},
          "SRS_ConfigPreview_RequirementFilled" =>   {:empty => [],:missing => []},
          "SRS_ConfigPreview_InformationFilled" =>   {:empty => [],:missing => []},
          "SRS_ConfigPreview_SrsFilled" =>           {:empty => [],:missing => []},
          "SWA_ConfigPreview_SpecFilled" =>          {:empty => [],:missing => []},
          "SWA_ConfigPreview_ModFilled" =>           {:empty => [],:missing => []},
          "SWA_ConfigPreview_InterfaceFilled" =>     {:empty => [],:missing => []},
          "SMD_ConfigPreview_UnitFilled" =>          {:empty => ["downstream_references"],:missing => []},

          "SRS_ConfigPreview_RequirementStruck" => {:empty   => ["verification_methods", "tags", "derived_feature", "derived_change_request", "upstream_asil", "upstream_security", "upstream_tags", "custom",
                                                                  "developer", "tester", "verification_criteria", "downstream_references", "upstream_references"],
                                                     :missing => []},
          "SWA_ConfigPreview_SpecStruck" =>        {:empty   => ["tags", "derived_feature", "derived_change_request", "upstream_asil", "upstream_security", "upstream_tags", "verification_criteria", "custom",
                                                                  "downstream_references", "upstream_references", "developer", "tester"],
                                                     :missing => []},
          "SWA_ConfigPreview_ModStruck" =>         {:empty   => ["reuse", "usage", "upstream_asil", "upstream_security", "custom",
                                                                  "developer", "location", "upstream_references"],
                                                     :missing => []},
          "SMD_ConfigPreview_UnitStruck" =>        {:empty   => ["tags", "verification_criteria", "derived_feature", "derived_change_request", "upstream_asil", "upstream_security", "upstream_tags", "downstream_references", "custom",
                                                                  "sources", "upstream_references", "developer", "tester"],
                                                     :missing => []},
        }

        expected.each do |id, map|
          (attributes + ["Custom"]).each do |attribute|
            attribute = attribute.downcase.gsub(" ", "_")
            [data_index, data_filled, data_special].each do |data_file|
              if data_file.exist?(id, attribute)
                expect(data_file.missing_class?(id, attribute)).to be map[:missing].include?(attribute)
                expect(data_file.empty_class?(id, attribute)).to be map[:empty].include?(attribute)
              end
            end
          end
        end
      end

      it 'shall also hide the vertical bar between "Tags" and "Upstream Tags" if at least one of them is hidden',
        doc_refs: [ 'DoxTrace_HTML_ConfigReadingMode'] do

        data = HtmlData.new("config", "special.html")

        expected = {
          "SWA_ConfigPreview_SpecParentTagsParent" => true,
          "SWA_ConfigPreview_SpecParentTagsNone" => true,
          "SWA_ConfigPreview_SpecParentTagsBoth" => false,
          "SWA_ConfigPreview_SpecParentTagsOnlyParent" => true,
          "SWA_ConfigPreview_SpecParentTagsOnlyChild" => true
        }

        expected.each do |id, empty|
          str = empty ? " dox-trace-attribute-empty" : ""
          bar_empty = /\A[^<]*<\/*span><span class="dox-trace-grey#{str}"> \|/
          table = data.getTableInternal(id, "tags")
          expect(table.match?(bar_empty)).to be true
        end
      end

      it 'shall hide a row if all attributes in this row are hidden', doc_refs: [ 'DoxTrace_HTML_ConfigReadingMode'] do
        data = HtmlData.new("config", "special.html")

        # two rows can disappear completely if empty/missing values are hidden
        expect(data.getTableInternal("SWA_ConfigPreview_SpecParentTagsHideIfEmpty", "status").scan(/hide-if-empty/).length).to be 2
      end

      it 'shall not add an unnecessary line break if "Developer", "Tester" and "Verification Methods" are hidden',
        doc_refs: [ 'DoxTrace_HTML_ConfigReadingMode'] do

        data = HtmlData.new("config", "special.html")

        expected = {
          "Input_ConfigPreview_RequirementDevTestAlways" => /\A-<\/span><br>/,
          "Input_ConfigPreview_RequirementDevTestMissing" => /\A-<\/span><span class="dox-trace-attribute-missing"><br><\/span>/,
          "Input_ConfigPreview_RequirementDevTestEmpty" => /\A-<\/span><span class="dox-trace-attribute-empty"><br><\/span>/
        }

        expected.each do |id, regex|
          table = data.getTableInternal(id, "verification_methods")
          expect(table.match?(regex)).to be true
        end
      end

    end
  end
end
