require "iron_response"
require "ecfs"

IronResponse::Responder.new(binding) do
  filings = ECFS::Filing.query.tap do |q|
    q.docket_number = params[:docket_number]
  end.get

  {
    length: filings.length
  }
end