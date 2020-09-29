require_relative './part_1_solution.rb'
require 'pry'


#apply_coupons
    # base case - with perfect coupon (number of items identical):
    #   adds a new key, value pair to the cart hash called 'ITEM NAME W/COUPON' (FAILED - 1)
    #   adds the coupon price to the property hash of couponed item (FAILED - 2)
    #   adds the count number to the property hash of couponed item (FAILED - 3)
    #   removes the number of discounted items from the original item's count (FAILED - 4)
    #   remembers if the item was on clearance (FAILED - 5)
    # more advanced cases:
    #   doesn't break if the coupon doesn't apply to any items
    #   can apply multiple coupons (FAILED - 6)
    #   doesn't break if there is no coupon (FAILED - 7)


# cart =  [{:item=>"AVOCADO", :price=>3.0, :clearance=>true, :count=>2}]
# coupons = [{:item=>"AVOCADO", :num=>2, :cost=>5.0}]
def apply_coupons(cart, coupons)

 i = 0
  coupons.each do |coupon|
    item_with_coupon = find_item_by_name_in_collection(coupon[:item], cart)
    item_is_in_basket = !!item_with_coupon
    count_is_big_enough_to_apply = item_is_in_basket && item_with_coupon[:count] >= coupon[:num]
    if item_is_in_basket and count_is_big_enough_to_apply
      cart << { item: "#{item_with_coupon[:item]} W/COUPON", 
                price: coupon[:cost] / coupon[:num], 
                clearance: item_with_coupon[:clearance],
                count: coupon[:num]
              }
      item_with_coupon[:count] -= coupon[:num]
    end
    i += 1
  end
  cart
# counter = 0
#   while counter < coupons.length
#     cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
#     couponed_item_name = "#{coupons[counter][:item]} W/COUPON"
#     cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
#     if cart_item && cart_item[:count] >= coupons[counter][:num]
#       if cart_item_with_coupon
#         cart_item_with_coupon[:count] += coupons[counter][:num]
#         cart_item[:count] -= coupons[counter][:num]
#       else
#         cart_item_with_coupon = {
#           :item => couponed_item_name,
#           :price => coupons[counter][:cost] / coupons[counter][:num],
#           :count => coupons[counter][:num],
#           :clearance => cart_item[:clearance],
#         }
#         cart << cart_item_with_coupon
#         cart_item[:count] -= coupons[counter][:num]
    
    
    
#       end
#     end
#     counter += 1
#   end
end

def apply_clearance(cart)
    cart.map do |key|
      if key[:clearance]
        key[:price] *= 0.8
 
end
 end
 cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
   final_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  
  total = 0

  final_cart.each do |item|
    total += item[:price] * item[:count]
  end

  total *= 0.9 if total > 100

  total.round(2)
  
end
