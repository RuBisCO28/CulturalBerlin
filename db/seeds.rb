require "csv"

CSV.foreach('db/csv/events.csv', headers: true) do |row|
  Event.create!(
    name: row['name'],
    date: row['date'].to_date,
    source: row['source'],
    url: row['url']
  )
end