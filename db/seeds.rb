# r = 0
# 20.times do |r|  
#   r = r + 1
#   p = 0
#   10.times do |p|
#     p = p + 1
#     Ticket.create(available: true, row: r, place: p)
#   end
# end


Event.create(info: 'Radiohead concert', cost: 60)
