module Refinery
  module Products
    class Category < Refinery::Core::BaseModel
      extend FriendlyId
      acts_as_nested_set

      translates :title, :slug

      friendly_id :title, :use => [:slugged, :globalize]

      belongs_to :photo, :class_name => '::Refinery::Image'

      has_many :categorizations, :dependent => :destroy, :foreign_key => :products_category_id
      has_many :products, :through => :categorizations, :source => :product

      validates :title, :presence => true, :uniqueness => true

      acts_as_indexed :fields => [:title]

      # If title changes tell friendly_id to regenerate slug when
      # saving record
      def should_generate_new_friendly_id?
        title_changed?
      end

      def self.translated
        with_translations(::Globalize.locale)
      end

      def product_count
        products.live.with_globalize.count
      end

      self.per_page = Refinery::Products.products_per_page
    end
  end
end
