# frozen_string_literal: true

module DatabaseSeeds
  class Main
    def self.execute
      DatabaseSeeds::Real::CurrenciesSeeds.new.execute
      DatabaseSeeds::Dummy::AccountsSeeds.new.execute
    end
  end
end
