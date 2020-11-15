# frozen_string_literal: true

module DatabaseSeeds
  class Main
    def self.execute
      DatabaseSeeds::Dummy::AccountsSeeds.new.execute
      DatabaseSeeds::Real::CurrenciesSeeds.new.execute
    end
  end
end
