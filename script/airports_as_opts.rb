# Invoke via
# $ ./script/runner script/airports_as_opts.rb
#

amee_cx = AMEE::Rails.connection
amee_cx.timeout = 20_000

m_def = "def self.airports\n  [\n"

r = amee_cx.get "/data/transport/plane/generic/airports/countries?itemsPerPage=999"
r = JSON.parse(r.body).to_openstruct

uk, row = [], []
r.children.dataItems.rows.each do |r|
  r.country == "United Kingdom" ? uk << r : row << r
end
divider = {"label" => "---", "IATACode" => "---" }.to_openstruct

all = uk + [divider] + row

all.each do |r|
  m_def << %Q{    ["#{r.label}", "#{r.IATACode}"],\n}
end

m_def << "  ]\nend"

puts m_def
