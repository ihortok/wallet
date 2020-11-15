# frozen_string_literal: true

module DatabaseSeeds
  module Real
    class CurrenciesSeeds
      def execute
        currencies.each do |currency|
          new_currency = Currency.find_or_initialize_by(code: currency[:code])
          new_currency.country = currency[:country]
          new_currency.symbol = currency[:symbol]
          new_currency.icon = currency[:icon]
          new_currency.save
        end
      end

      private

      def currencies
        [
          { country: 'Ukraine', code: 'UAH', symbol: '₴', icon: 'ukraine' },
          { country: 'United States', code: 'USD', symbol: '$', icon: 'us' },
          { country: 'European Union', code: 'EUR', symbol: '€', icon: 'eu' },
          { country: 'United Kindom', code: 'GBP', symbol: '£', icon: 'uk' },
          { country: 'Poland', code: 'PLN', symbol: 'zł', icon: 'poland' },
          { country: 'Thailand', code: 'THB', symbol: '฿', icon: 'thailand' },
          { country: 'Hungary', code: 'HUF', symbol: 'Ft', icon: 'hungary' }
        ]
      end
    end
  end
end
