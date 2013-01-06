class Api::MessagesController < Api::BaseController
  before_filter :verify_auth_token

  # GET /api/messages[?limit=:limit][&after=:after][&before=:before]
  # Notes: limit is 15 by default, and cannot exceed 50
  # Returns: JSON
  # Requires authorization: yes
  def index
    limit  = params[:limit]
    limit ||= 15
    before = params[:before]
    after  = params[:after]

    # TODO: check parameters

    # Build our query
    msg_query = @user.messages
    if !before.nil?
      msg_query = msg_query.where("created_at > ?", Time.at(before))
    end
    if !after.nil?
      msg_query = msg_query.where("created_at <= ?", Time.at(after))
    end
    msg_query = msg_query.limit(limit)

    msg_list = []
    msg_query.all.each do |msg|
      msg_list << msg_as_hash(msg)
    end

    render :status => 200,
           :json => {
             status: 200,
             timestamp: Time.now.to_i,
             messages: msg_list
           }
  end

  # GET /api/messages/:id
  # Returns JSON
  # Requires authorization: yes
  def show
    msg = @user.messages.find(params[:id])
    if msg.nil?
      render json_status_response(404, "Tag not found")
      return
    end

    render :status => 200,
           :json => msg_as_hash(msg).merge({
                      status: 200,
                      timestamp: Time.now.to_i
                    })
  end

  # POST /api/send?tag=:tag
  # Parameters: contents=:contents
  # Returns: JSON
  # Requires authorization: yes
  def send_message
    tag = Tag.find_by_tid(params[:tag])
    if tag.nil?
      render json_status_response(404, "Tag not found")
      return
    end

    if @user.send_message(tag, params[:contents])
      render json_status_response(200, "Message sent successfully")
    else
      render json_status_response(400, "Bad request")
    end
  end

  # POST /api/messages/delete?id=:id
  # Returns: JSON
  # Requires authorization: yes
  def delete
    msg = @user.messages.find(params[:id])
    if msg.nil?
      render json_status_response(404, "Message not found")
      return
    end

    msg.destroy
    render json_status_response(200, "Message deleted successfully")
  end

  private
  def msg_as_hash(msg)
    return nil if msg.nil?

    msg_sender = msg.sender
    return {
      id: msg.id,
      sender: {
        name: msg_sender.display_name
        # TODO: picture_url
      },
      contents: msg.contents,
      received: msg.created_at.to_i
    }
  end
end
