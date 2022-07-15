class ReservationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  # get /index
  def index

    # cost, event information

    @reservations = Reservation.order(created_at: :asc)
    pp @reservations.count
    reservations_details = []
    @reservations.each do |reservation|
      reservations_details << {
        id: reservation.id, 
        tickets_quantity: reservation.tickets.count, 
        status: reservation.aasm_state,
        event_info: reservation.event.info, 
        cost: reservation.tickets.count * reservation.event.cost
      }

    end
    
    respond_to do |format|
      format.json do
        render json: reservations_details, root: true
      end
    end
  end
  
  def create
    option = params[:option]
    ticket_ids = params[:ticket_ids]
    event_id = params[:event_id]
   
    tickets = []
    ticket_ids.each do |ticket_id|
      ticket = Ticket.find(ticket_id)
      if ticket.available
        tickets << ticket
        Ticket.lock("FOR UPDATE NOWAIT").find_by(ticket_id)
      else
        error_response('The ticket is not available')
        return
      end
    end

    case option
    when nil   
      make_reservation(tickets, event_id)
    when "even"
      tickets.count.even? ? make_reservation(tickets, event_id) : error_response('The amount of tickets in not even')
    when "all_together"
      check_together(tickets) ? make_reservation(tickets, event_id) : error_response('The tickets are not together')
    when "avoid_one"
      check_avoid_one(tickets) ? make_reservation(tickets, event_id) : error_response('Only one ticket left')
    else
      error_response("Option has an invalid value: #{option}")
    end
  end



  # def pay
  #   @reservation = Reservation.find params[:id]


  #   if @reservation.pay!

  #   else
  #     @reservation.destroy
  #     @reservation.tickets.each do |ticket|
  #       ticket.available = true
  #       ticket.save
  #     end
  #   end
  # end

  def destroy
    @reservation = Post.find(params[:id])

    if @reservation.destroy
      confirmation_response('The reservation was successfully deleted') 
    else
      error_response('The reservation was not deleted')
    end
  end


  private

  def make_reservation tickets, event_id
    @reservation = Reservation.new()
    @reservation.event_id = event_id
    if @reservation.save
      tickets.each do |ticket|
        ticket.reservation = @reservation
        ticket.available = false
        ticket.save
      end
    else
      error_response('The reservation was not created') 
    end
    
    respond_to do |format|
      format.json do
        render json:  {tickets: tickets}
      end
    end
  end

  def check_together tickets
    tickets.each do |ticket|
      if ticket.row != tickets.first.row
        return false
      end
    end
    places = []
    tickets.each do |ticket|
      places << ticket.place
    end

    places.sort!
    place_min = places.first
    place_max = places.last

    check_range = place_min..place_max
    check_list = check_range.to_a

    places & check_list == check_list
  end

  def check_avoid_one tickets
    available_tickets = 0
    Ticket.all.each do |t|
      if t.available
        available_tickets += 1
      end
    end
    available_tickets - tickets.count > 1
  end

  def error_response error_message
    respond_to do |format|
      format.json do
        render json:  {Error: error_message}
      end
    end
  end 

  def confirmation_response message
    respond_to do |format|
      format.json do
        render json:  {confirmation_response: message}
      end
    end
  end
end