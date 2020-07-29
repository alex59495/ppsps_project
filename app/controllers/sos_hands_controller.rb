class SosHandsController < ApplicationController
  before_action :find_sos_hand, only: [ :update, :show, :destroy, :edit ]

  def index
    @sos_hands = policy_scope(SosHand)
  end

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

  def edit
    authorize @sos_hand
  end

  def update
    authorize @sos_hand
    if @sos_hand.update(params_sos_hand)
      redirect_to sos_hands_path
    else
      render :edit
    end
  end

  private
  def params_sos_hand
    params.require(:sos_hand).permit(:address, :name, :phone)
  end

  def find_sos_hand
    @sos_hand = SosHand.find(params[:id])
  end
end
