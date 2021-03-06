include SessionsHelper
require_relative '../../lib/amount.rb'

class ChargesController < ApplicationController

  def new
   @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "Premium Membership",
     amount: Amount.default
   }
  end

  def create
   # Creates a Stripe Customer object, for associating with the charge
   customer = Stripe::Customer.create(
     email: current_user.email,
     card: params[:stripeToken]
   )

   charge = Stripe::Charge.create(
     customer: customer.id, # This is NOT the user_id in your app
     amount: Amount.default,
     description: "Premium Membership - #{current_user.email}",
     currency: 'usd'
   )

   flash[:notice] = "Thanks #{current_user.name}, your account was upgraded to premium."
   current_user.premium!
   redirect_to wikis_path

   # Stripe will send back CardErrors, with friendly messages
   # when something goes wrong.
   # This `rescue block` catches and displays those errors.
   rescue Stripe::CardError => e
     flash[:alert] = e.message
     redirect_to new_charge_path
  end

end
