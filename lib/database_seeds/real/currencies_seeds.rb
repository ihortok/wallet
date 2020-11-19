# frozen_string_literal: true

module DatabaseSeeds
  module Real
    class CurrenciesSeeds
      def execute
        currencies.each do |currency|
          new_currency = Currency.find_or_initialize_by(code: currency[:code])
          new_currency.id = currency[:id]
          new_currency.country = currency[:country]
          new_currency.symbol = currency[:symbol]
          new_currency.icon = currency[:icon]
          new_currency.rate = currency[:rate]
          new_currency.save
        end
      end

      private

      def currencies
        [
          { id: 1, country: 'Ukraine', code: 'UAH', symbol: '₴', icon: 'ukraine', rate: 28.35 },
          { id: 2, country: 'United States', code: 'USD', symbol: '$', icon: 'us', rate: 1.0 },
          { id: 3, country: 'European Union', code: 'EUR', symbol: '€', icon: 'eu', rate: 0.84 },
          { id: 4, country: 'United Kindom', code: 'GBP', symbol: '£', icon: 'uk', rate: 0.75 },
          { id: 5, country: 'Poland', code: 'PLN', symbol: 'zł', icon: 'poland', rate: 3.76 },
          { id: 6, country: 'Thailand', code: 'THB', symbol: '฿', icon: 'thailand', rate: 30.37 },
          { id: 7, country: 'Hungary', code: 'HUF', symbol: 'Ft', icon: 'hungary', rate: 301.6 }
        ]
      end
    end
  end
end
