class Api::PurchaseHeadersController < ApplicationController

  def index
    @purchase_headers = PurchaseHeader.includes(:purchase_details)

    respond_to do |format|
      format.html
      format.json
    end
  end

  def new
    @purchase_headers = PurchaseHeader.new
  end

  def create
    @purchase_headers = PurchaseHeader.new(:amount => params[:amount])
    params[:items].each do |item|
      @purchase_headers.purchase_details.build(:name => item[1][:name], :price => item[1][:price], :quantity => item[1][:quantity])
    end

    respond_to do |format|
      if @purchase_headers.save
        format.html { redirect_to @purchase_headers, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: api_purchase_header_url(@purchase_headers) }
      else
        format.html { render :new }
        format.json { render json: @purchase_headers.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def purchase_header_params
      params.require(:purchase_header).permit(:amount)
    end

    def purchase_detail_params
      params.require(:item).permit(:name, :price, :quantity)
    end
end
