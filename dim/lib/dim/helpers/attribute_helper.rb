# frozen_string_literal: true

require_relative 'file_helper'

module Dim
  module Helpers
    module AttributeHelper
      include FileHelper

      CHECK_SINGLE_ENUM = :check_single_enum
      CHECK_MULTI_ENUM = :check_multi_enum
      FORMAT_STYLES = {
        'list' => 'list',
        'multi' => 'multi',
        'single' => 'single',
        'split' => 'split',
        'text' => 'text'
      }.freeze
      @filepath = ''

      def resolve_attributes(folder:, filename:)
        @filepath = "#{folder}/#{filename}"
        attributes = open_yml_file(folder, filename, allow_empty_file: true)
        unless attributes
          puts "Warning: empty file detected; skipped loading of #{filename}"
          return
        end

        check_for_default_attributes(attributes, filename)

        attributes.each do |attribute, attr_config|
          attr_config.transform_keys!(&:to_sym)

          change_type_to_format_style(attr_config)
          validate_format_style(attribute, attr_config)
          add_check_value(attr_config)
          validate_default(attribute, attr_config)
          validate_allowed(attribute, attr_config)
          validate_allowed_for_enum(attribute, attr_config)
          validate_default_for_enum(attribute, attr_config)

          symbolize_values(attr_config)
        end

        attributes
      end

      def check_for_default_attributes(attributes, filename)
        common_values = Requirement::SYNTAX.keys & attributes.keys
        return if common_values.empty?

        Dim::ExitHelper.exit(
          code: 1,
          filename: @filepath,
          msg: 'Defining standard attributes as a custom attributes is not allowed; ' \
               "#{common_values.join(',')} in #{filename}"
        )
      end

      # TODO: change "format_style" to "type" in requirements syntax and then remove this conversion
      def change_type_to_format_style(config)
        config[:format_style] = config.delete(:type)
      end

      def validate_format_style(attribute, config)
        return if FORMAT_STYLES.values.include?(config[:format_style])

        exit_with_error(config: 'type', config_value: config[:format_style], attribute: attribute)
      end

      def add_check_value(config)
        config[:check] = CHECK_SINGLE_ENUM if config[:format_style] == FORMAT_STYLES['single']
        config[:check] = CHECK_MULTI_ENUM if config[:format_style] == FORMAT_STYLES['multi']
      end

      def validate_default(attribute, config)
        return unless config[:default] == 'auto'

        exit_with_error(config: 'default', config_value: config[:default], attribute: attribute)
      end

      def validate_allowed(attribute, config)
        return if config[:allowed].nil? || config[:allowed].is_a?(Array)

        exit_with_error(config: 'allowed', config_value: config[:allowed], attribute: attribute)
      end

      def validate_allowed_for_enum(attribute, config)
        return unless FORMAT_STYLES.fetch_values('single', 'multi').include?(config[:format_style])

        return if config[:allowed].is_a?(Array) && config[:allowed].map { |val| val.is_a?(String) }.all?

        Dim::ExitHelper.exit(
          code: 1,
          filename: @filepath,
          msg: "Allowed value must be list of strings; invalid allowed value for #{attribute}"
        )
      end

      def validate_default_for_enum(attribute, config)
        return unless FORMAT_STYLES.fetch_values('single', 'multi').include?(config[:format_style])

        return if config[:allowed].include?(config[:default])

        Dim::ExitHelper.exit(
          code: 1,
          filename: @filepath,
          msg: "default value for #{attribute} must be from allowed list of #{config[:allowed]}"
        )
      end

      def symbolize_values(config)
        config[:format_style] = config[:format_style].to_sym if config[:format_style]
        config[:format_shift] = config[:format_shift].to_i
        config[:default] = '' unless config[:default]
      end

      private

      def exit_with_error(config:, config_value:, attribute:)
        msg = "Invalid value \"#{config_value}\" for #{config} detected for attribute #{attribute}"
        Dim::ExitHelper.exit(code: 1, filename: @filepath, msg: msg)
      end
    end
  end
end
