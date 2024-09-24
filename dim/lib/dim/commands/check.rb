require_relative '../globals'

module Dim
  class Check
    SUBCOMMANDS['check'] = self

    def initialize(_loader); end

    def execute(silent: true)
      # checks are always done after loading, so this is just a placeholder for command line option
    end
  end
end
