module Refinery
  module Products
    class ProductsController < ShopController
      include Refinery::Products::ControllerHelper

      before_filter :find_page
      before_filter :find_all_products
      before_filter :find_product, only: :show

      protected

        def find_page
          @page = Refinery::Page.find_by(:link_url => "#{Refinery::Products.shop_path}#{Refinery::Products.products_path}")
        end

    end
  end
end
