class ChargesController < ApplicationController
  def create

  	customer = Stripe::Customer.create(
  		email: current_user.email,
  		card: params[:stripeToken]
  	)

  	charge = Stripe::Charge.create(
  		customer: customer.id,
  		amount: 25_00,
  		description: "Blocipedia Membership - #{current_user.email}",
  		currency: 'usd'
  	)

  	if charge.paid
  		flash[:notice] = "Thanks for paying our bills, #{current_user.email}."
  		current_user.premium!
  		redirect_to wikis_path
  	end

  	rescue Stripe::CardError => e
	  	flash[:alert] = e.message
	  	redirect_to new_charge_path
  end

  def destroy
  	flash[:notice] = "Tu n'es plus premium! Au revoir, la vie privée!"
  	current_user.member!
    Wiki.where(user_id: current_user.id).each { |w| w.update(private: false) }
  	redirect_to wikis_path
  end
end
