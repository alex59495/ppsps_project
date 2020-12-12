class SosHandsController < ApplicationController
  before_action :find_sos_hand, only: [ :update, :show, :destroyed, :edit ]

  def index
    authorize SosHand
    if params[:query]
      @sos_hands = policy_scope(SosHand.search_sos_hand(params[:query]))
      # We are using form_with in the index view so it respond with ajax, to handle the response we have to activate a format response
      respond_to do |format|
        # Respond with the index.js.erb
        format.js {}
      end
    else
      @sos_hands = policy_scope(SosHand.all)
      # Must be able to respond in HTML (when load the page) and JS (when click on button Show all databse)
      respond_to do |format|
        format.html {}
        format.js {}
      end
    end

    # Useful for the infinite scroll
    @sos_hands_page = @sos_hands.page
    @endpoint = pagination_sos_hands_path
    @page_amount = @sos_hands_page.total_pages

    @sos_hand = SosHand.new
  end

  def create
    @sos_hand = SosHand.new(params_sos_hand)
    @sos_hand.company = current_user.company
    authorize @sos_hand
    if @sos_hand.save
      # Create an ordered list to use in the view 'sos_hand/_form_field_sos_hand'
      @sos_hands = SosHand.all.sort_by { |sos_hand| sos_hand.name }
      # Respond with the view sos_hand/create.js.erb to close the modal and come back to the form
      respond_to do |format|
        format.js {}
      end
    else
      # Respond with the .js.erb to print the modal with errors
      respond_to do |format|
        format.js { render 'ppsps/modal_sos_hand' }
      end
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

  def destroyed
    authorize @sos_hand
    @sos_hand.is_destroyed = true
    if @sos_hand.save
      redirect_to sos_hands_path
    else
      flash.now[:error] = "L'élément n'a pas pu être supprimé"
    end
  end

  # Useful for the infinite loop
  def pagination
    if params[:query]
      @sos_hands = policy_scope(SosHand.search_sos_hand(params[:query]))
    else
      @sos_hands = policy_scope(SosHand.all)
    end
    authorize @sos_hands
    @sos_hands_page = @sos_hands.page(params[:page])
    render 'sos_hands/_element', collection: @sos_hands_page, layout: false
  end

  private
  def params_sos_hand
    params.require(:sos_hand).permit(:address, :name, :phone, :company)
  end

  def find_sos_hand
    @sos_hand = SosHand.find(params[:id])
  end
end
