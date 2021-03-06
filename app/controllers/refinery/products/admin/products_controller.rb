module Refinery
  module Products
    module Admin
      class ProductsController < ::Refinery::AdminController

        crudify :'refinery/products/product',
                :order => 'updated_at DESC',
                :include => [:translations]

        helper :'refinery/products/admin/categories'

        before_filter :find_all_categories,
                      :only => [:new, :edit, :create, :update]

        before_filter :check_category_ids, :only => :update

        def uncategorized
          @products = Refinery::Products::Product.uncategorized.page(params[:page])
        end

        private
          def product_params
            params.require(:product).permit(
              :title,
              :body,
              :published_at,
              :draft,
              propertizations_attributes: [ :id, :product_id, :products_property_id, :value, :_destroy ],
              :category_ids => []
            )
          end

        protected

          def find_all_categories
            @categories = Refinery::Products::Category.all
          end

          def check_category_ids
            product_params[:category_ids] ||= []
          end
      end
    end
  end
end
