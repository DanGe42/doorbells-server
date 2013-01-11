require 'net/https'
# require 'open-uri'

class Jobs::NotifyUser
  @queue = :notifications

  HEADERS = {
    "Content-Type" => "application/json",
    "Authorization" => APP_CONFIG["gcm_api_key"]
  }

  def self.perform(message_id)
    message = Message.find(message_id)
    reg_ids = message.user.devices

    if reg_ids.empty?
      Rails.logger.info "User with ID #{message.user_id} has no devices. " <<
                  "Cancelling job..."
      return
    end

    url = URI.parse(APP_CONFIG["gcm_url"])
    req = Net::HTTP::Post.new(url.path, HEADERS)
    payload = build_payload(reg_ids, message.contents, true).to_json
    req.body = payload

    con = Net::HTTP.new(url.host, url.port)
    con.use_ssl = true

    response = con.start do |http|
      Rails.logger.info "[NotifyUser] Sending GCM message to IDs " <<
                        "#{payload[:registration_ids]}"
      http.request(req)
    end

    Rails.logger.debug "Response code: #{response.code}"
    Rails.logger.debug "Response message: #{response.message}"
    Rails.logger.debug "Response body: #{response.body}"
  end

  private
  def self.build_payload(reg_ids, message, dry_run=false)
    message ||= ""
    payload = {
      registration_ids: reg_ids,
      collapse_key: "New messages",
      time_to_live: 1.week.to_i,
      data: {
        message: message
      },
      dry_run: dry_run
    }

    return payload
  end
end
