require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'time'

def clean_zipcode(zipcode)
  zipcode.to_s[0..4].rjust(5,'0')
end

def clean_phone_number(phone_number)
  clean_number = phone_number.gsub(/[()\-,. ]/, '')
  if !clean_number.length.between?(10, 11)
    raise ArgumentError.new("Must be 10 or 11 digits (entered: #{clean_number})")
  elsif clean_number.length == 11 && clean_number[0] == '1'
    clean_number = clean_number[1..-1]
  elsif clean_number.length == 11 && clean_number[0] != '1'
    raise ArgumentError.new("If 11 digits first number must be 1 (USA) (entered: #{clean_number}")
  end
  clean_number
end

def legislators_by_zipcode(zipcode)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'
  
  begin
    legislators = civic_info.representative_info_by_address(
      address: zipcode,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action-find-elected-officials'
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')
  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

def add_to_mailing_list(id, phone_number)
  # puts "#{id} #{phone_number}"
end

def peak_registration_hours

end

puts 'Event Manager Initialized!'

file_name = 'event_attendees.csv'
contents = CSV.open(
  file_name,
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new(template_letter)

hours = {}
contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)
  begin
    phonenumber = clean_phone_number(row[:homephone])
  rescue => e
    phonenumber = nil
  end

  form_letter = erb_template.result(binding)
  save_thank_you_letter(id, form_letter)

  add_to_mailing_list(id, phonenumber) unless phonenumber.nil?
  
end

# group by hour and get the max
contents.rewind
top_hour = contents.group_by do |row|
  Time.strptime(row[:regdate], '%D %H:%M').hour
end.max_by do |key, value|
  value.size
end

puts "Top hour: #{top_hour[0]} Registrations: #{top_hour[1].size}"

# group by hour and get the max
contents.rewind
top_wday = contents.group_by do |row|
  Time.strptime(row[:regdate], '%D %H:%M').strftime('%A')
end.max_by do |key, value|
  value.size
end

puts "Top weekday: #{top_wday[0]} Registrations: #{top_wday[1].size}"
