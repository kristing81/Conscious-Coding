class ChargesController < ApplicationController

  def new
    @amount = 1000
    @stripe_btn_data = {
    key: "#{ Rails.configuration.stripe[:publishable_key] }",
    description: "Conscious Coding Job Posting",
    amount: @amount
   }
  end
  def create
  @amount = 1000
  @email = 
 
  customer = Stripe::Customer.create(
     email: params[:stripeEmail],
     card: params[:stripeToken]
  )
 
  charge = Stripe::Charge.create(
     customer: customer.id, 
     amount: @amount,
     description: "Conscious Coding Job Posting",
     currency: 'usd'
  )
 
  flash[:success] = "Thanks for choosing Conscious Coding for your recruitment need!"
  redirect_to jobs_path

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
 end
end
