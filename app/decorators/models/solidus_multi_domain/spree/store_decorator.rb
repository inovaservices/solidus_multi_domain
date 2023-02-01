# frozen_string_literal: true

module SolidusMultiDomain
  module Spree
    module StoreDecorator
      def self.prepended(base)
        base.class_eval do
          has_and_belongs_to_many :products, join_table: 'spree_products_stores'
          has_many :taxonomies
          has_many :orders

          has_many :store_shipping_methods
          has_many :shipping_methods, through: :store_shipping_methods

          has_and_belongs_to_many :promotion_rules, class_name: 'Spree::Promotion::Rules::Store', join_table: 'spree_promotion_rules_stores', association_foreign_key: 'promotion_rule_id'

          has_one_attached :logo, dependent: :purge_later
          # validates :logo, allow_nil: true, if: -> { respond_to?(:logo_file_name) }

        end
      end

      ::Spree::Store.prepend self
    end
  end
end
