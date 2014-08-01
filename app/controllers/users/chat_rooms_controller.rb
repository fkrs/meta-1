class Users::ChatRoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.joins(:watchings).
      where('subscription = true').
      where('watchings.user_id = ?', current_user.id)

    render json: {
      chat_rooms: ActiveModel::ArraySerializer.new(@products, each_serializer: ChatRoomSerializer),
      sort_keys: current_user.recent_product_ids.map{|pid| "chat_#{pid}"}
    }
  end
end