require_relative './part_1_solution.rb'

cart_example = [
  {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 3},
  {:item => "KALE",    :price => 3.00, :clearance => false, :count => 1}
]

coupons_example = [
  {:item => "AVOCADO", :num => 2, :cost => 5.00}
]

expected_outcome_example = [
  {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 1},
  {:item => "KALE", :price => 3.00, :clearance => false, :count => 1},
  {:item => "AVOCADO W/COUPON", :price => 2.50, :clearance => true, :count => 2}
]

def apply_coupons(cart, coupons)  
  cart.each do |grocery_item|
    food_name = grocery_item[:item]
    coupons.each do |coupon_item|
    coupon_food_name = coupon_item[:item]
      if food_name == coupon_food_name
        if grocery_item[:count] >= coupon_item[:num]
          added_item = {}
          added_item[:item] = "#{food_name} W/COUPON"
          added_item[:price] = coupon_item[:cost] / coupon_item[:num]
          added_item[:clearance] = grocery_item[:clearance]
          added_item[:count] = coupon_item[:num]
          grocery_item[:count] = grocery_item[:count] - coupon_item[:num]
          cart.push(added_item)
        end
      end
    end 
  end
  return cart
end 

def apply_clearance(cart)
 cart.each do |grocery_item|
   if grocery_item[:clearance] == true 
     grocery_item[:price] = (grocery_item[:price] * 0.8).round(2)
   end
 end
end

def checkout(cart, coupons)
 cart = consolidate_cart(cart)
 cart = apply_coupons(cart, coupons)
 cart = apply_clearance(cart)
 final_total = 0
 cart.each do |grocery_item|
   final_total += grocery_item[:price] * grocery_item[:count]
 end
 if final_total > 100 
   final_total *= 0.9
 end
 return final_total
end

=begin
NOTES: 
apply_coupons:
# Consult README for inputs and outputs
#
# REMEMBER: This method **should** update cart

FIRST ATTEMPT:
def apply_coupons(cart, coupons)  
coupon_cart = []
 cart.each do |cart_item|
    coupons.each do |coupon_item|
      if cart_item[:item] == coupon_item[:item]
        if cart_item[:count] >= coupon_item[:num] 
          divisibility_integer = cart_item[:count].div(coupon_item[:num])
          if cart_item[:count] % coupon_item[:num] == 0 
            cart.delete(cart_item)
            coupon_item[:item] == "#{cart_item[:item]} W/COUPON"
            coupon_item[:price] == coupon_item[:cost] / coupon_item[:num]
            coupon_item[:clearance] == true
            coupon_item[:count] == cart_item[:count] - divisibility_integer
            coupon_cart.push(coupon_item)
          else
            cart_item[:count] = (cart_item[:count] - (coupon_item[:num] * divisibility_integer))
          end
        end 
      end 
    end #end of interation through coupons
  end #end of iteration through cart
  return coupon_cart
end #end of method

FIRST ATTEMPT PSEUDOCODE:
#create result empty array
 #iterate over cart items
  #iterate over coupon items 
   #if the item name in the cart matches the item name in the coupon array
    #if the cart item count is greater than or equal to the number count in the coupon item
     #take the cart_item[:count] and divide it by the coupon_item[:num]
     #get the amount of leftover items that cannot have coupons applied to them 
     #create a key/value pair for the coupon item equal to the amount of applicable cart items
     #use the count applicable to the coupons and apply coupon stuff
     #divide coupons[:cost] by coupons[:num] to create a price key and value 
       #change item name to item w/ coupon, add the price key and value, make clearance is equal to true, include the updated count 
    #add any remaining cart items result array with the updated count, or delete the object if the count is 0 
     #add the coupon object to the result array 
#return result array 

PART OF SECOND ATTEMPT:
        # if grocery_item[:count] % coupon_item[:num] == 0 
        #   grocery_item[:count] = 0 
        #   coupon_item[:item] = "#{food_name} W/COUPON"
        #   coupon_item[:num] = coupon_item[:price]
        #   coupon_item[:price] = coupon_item[:cost] / coupon_item[:num]
        #   coupon_item[:clearance] = "true"
        #   coupon_item[:count] = grocery_item[:count]
        #   cart.push(coupon_item)
        # else
        #   grocery_item[:count] = (grocery_item[:count] % coupon_item[:num])
        #   coupon_item[:item] = "#{food_name} W/COUPON"
        #   coupon_item[:num] = coupon_item[:price]
        #   coupon_item[:price] = coupon_item[:cost] / coupon_item[:num]
        #   coupon_item[:clearance] == "true"
        #   coupon_item[:count] = grocery_item[:count]
        #   cart.push(coupon_item)
        # end
        
APPLY CLEARANCE NOTES:
# Consult README for inputs and outputs
#
# REMEMBER: This method **should** update cart

CHECKOUT NOTES:
# Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
=end
