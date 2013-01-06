class Api::TagsController < Api::BaseController
  before_filter :verify_auth_token

  # GET /api/tags/:id
  # Returns: JSON
  # Requires authorization: yes
  def show
    tag = Tag.find_by_tid(params[:id])
    if tag.nil?
      render json_status_response(404, "Tag not found")
      return
    end

    render :status => 200,
           :json => tag_as_hash(tag).merge({
                      status: 200,
                      # TODO csrf
                    })
  end

  # GET /api/tags
  # Returns: JSON
  # Requires authorization: yes
  def index
    tags_list = []
    @user.tags.find_each do |tag|
      tags_list << tag_as_hash(tag, false)
    end

    render :status => 200,
           :json => {
             status: 200,
             tags: tags_list
           }
  end

  # POST /api/tags/create
  # Parameters: location=:location
  # Returns: JSON
  # Requires authorization: yes
  def create
    tag = @user.tags.new(:location => params[:location])

    if tag.save
      render :status => 200,
             :json => tag_as_hash(tag).merge(status: 200)
    else
      render :status => 400,
             :json => {
               status: 400,
               message: "Bad request",
               errors: tag.errors,
             }
    end
  end

  # POST /api/tags/update?id=:id
  # Parameters: location=:location
  # Returns: JSON
  # Requires authorization: yes
  def update
    tag = @user.tags.find_by_tid(params[:id])
    if tag.nil?
      render json_status_response(404, "Tag not found")
      return
    end

    if not tag.update_attributes(params[:location])
      render json_status_response(400, "Could not update tag location")
      return
    end

    render json_status_response(200, "Successfully updated tag")
  end

  # POST /api/tags/delete?id=:id
  # Returns: JSON
  # Requires authorization: yes
  def destroy
    tag = @user.tags.find_by_tid(params[:id])
    if tag.nil?
      render json_status_response(404, "Tag not found")
      return
    end

    tag.destroy
    render json_status_response(200, "Tag removed successfully")
  end

  private
  def tag_as_hash(tag, include_user=true)
    return nil if tag.nil?

    if include_user 
      tag_user = tag.user

      return {
        id: tag.tid,
        location: tag.location,
        user: {
          name: tag_user.display_name
          # TODO: picture_url
        }
      }
    else
      return {
        id: tag.tid,
        location: tag.location
      }
    end
  end
end
