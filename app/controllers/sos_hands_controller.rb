class SosHandsController < ApplicationController
  def new
    @sos_hand = SosHand.new
    authorize @sos_hand
  end

  def create
    @sos_hand = SosHand.new(params_sos_hand)
    authorize @sos_hand
    if @sos_hand.save
      redirect_to new_ppsp_path
    else
      render :new
    end
  end

  private
  def params_sos_hand
    params.require(:sos_hand).permit(:address, :name, :phone)
  end
end
