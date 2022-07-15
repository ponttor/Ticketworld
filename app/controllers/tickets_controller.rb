class TicketsController < ApplicationController



  # def reserve_one
  #   @ticket = Ticket.find(params[:id])
  #   @reservation = @ticket.reservation
    
  #   if ticket.available
  #     @ticket.available = false
  #     redirect_to reserve_reservation_path, method: :patch, notice: 'The ticket was successfully reserved'
  #   else
  #     redirect_to root_path, notice: 'The ticket is not available'
  #   end

  # end

  def make_even
    # @ticket = Ticket.find(params[:id])
    # if ticket.available
    #   @ticket.available = false
    # else
    #   redirect_to root_path, notice: 'The ticket is not available'
    # end

    redirect_to root_path, notice: 'The ticket is not available'


  end

  def all_together
    @ticket = Ticket.find(params[:id])
  end

  def make_avoid_one
    @ticket = Ticket.find(params[:id])
    
  end

  private

  def tickets_params
    params.require(:ticket).permit(:available, :row, :place, :reservation_id)
  end
end
