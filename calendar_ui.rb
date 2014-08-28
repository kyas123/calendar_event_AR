require 'pry'
require 'bundler/setup'
Bundler.require(:default)


ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["development"])
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }


def welcome
  system 'clear'
  puts "[1] > Go to event menu"
  puts "[2] > go to view menu"
  puts "[E] > Exit"

  case (gets.chomp.upcase)
  when '1'
    event_menu
  when '2'
    view_menu
  when 'E'
    puts "Have an excellent day!"
    exit
  else
    puts "Invalid menu option."
    sleep 1
  end
  welcome
end

def event_menu
  system 'clear'
  puts "[1] > Add event"
  puts "[2] > Edit event"
  puts "[3] > Delete event"
  puts "[4] > List all events"
  puts "[5] > List all upcoming events"
  puts "[M] > Return to Main Menu"
  case gets.chomp.upcase
  when '1'
    add_event
  when '2'
    edit_event
  when '3'
    delete_event
  when '4'
    list_event
  when '5'
    order_event
  when 'M'
    welcome
  else
    puts "Invalid menu option."
    sleep 1
  end
end


def view_menu
  system 'clear'
  puts "[1] > View by Day"
  puts "[2] > View by Week"
  puts "[3] > View by Month"
  puts "[M] > Return to Main Menu"
  case gets.chomp.upcase
  when '1'
    view_day
  when '2'
    view_week
  when '3'
    view_month
  when 'M'
    welcome
  else
    puts "Invalid menu option."
    sleep 1
  end
end

def add_event
  system 'clear'
  puts "Please enter event description"
  description = gets.chomp.capitalize
  puts "Please enter the location"
  loc = gets.chomp
  puts "Please enter start date (YYYY-MM-DD HH:MM:SS)"
  s_date = gets.chomp
  puts "Please enter end date (YYYY-MM-DD HH:MM:SS)"
  e_date = gets.chomp
  new_event = Event.create({description: description, location: loc, start_date: s_date, end_date:e_date})
  puts "#{description} has been added to your calendar!"
  sleep(1)
  welcome
end

def list_event
  "Here is a list of your events."
  Event.all.each_with_index { |event, index| puts "#{index + 1} #{event.description}"}
  sleep(2)
end

def delete_event
  puts "Here is a list of your events."
  Event.all.each_with_index { |event, index| puts "#{index + 1} #{event.description}"}
  puts "Please select from the following event using its id number."
  event_id = gets.chomp.to_i - 1
  current_event = Event.all[event_id]
  current_event.destroy
  puts "Your event has been removed"
  sleep(2)
  welcome
end



def edit_event
  system 'clear'
  list_event
  puts "Please select from the following event using its id number."
  event_id = gets.chomp.to_i - 1
  current_event = Event.all[event_id]
  puts "what would you like to edit?"
  puts "Press [1] to edit description"
  puts "Press [2] to edit location"
  puts "Press [3] to edit start time"
  puts "Press [4] to edit end time"
  case gets.chomp
  when '1'
    puts "Please enter new description"
    new_desc = gets.chomp
    current_event = Event.update({description: new_desc})
  when '2'
    puts "Please enter new location"
    new_loc = gets.chomp
    current_event = Event.update({location: new_loc})
  when '3'
    puts "Please enter new description"
    new_start = gets.chomp
    current_event = Event.update({start_date: new_start})
  when '4'
    puts "Please enter new description"
    new_end = gets.chomp
    current_event = Event.update({end_date: new_end})
    else
    puts "Invalid menu option."
    sleep 1
    edit_event
  end
end

def order_event
  results = Event.order('start_date ASC')
  results.all.each do |result|
    if result.start_date > Time.now
      puts result.description
      puts result.start_date
    end
  end
    puts "Press any key to continue"
    gets
end

def view_day
  events = []
  puts "Here are today's events."
   Event.all.each do |result|
    if result.start_date.day == Time.now.day &&
      result.start_date.month == Time.now.month
      puts result.description
      events << result.description
    end
  end
    if events == []
      puts "You have no events today."
    end
  puts "Press any key to continue"
  gets
end

def view_week
  events = []
  puts "Here are this week's events."
   Event.all.each do |result|
   if (result.start_date.day/7) == (Time.now.day/7) &&
    result.start_date.month == Time.now.month
    puts results.description
    events << results.description
    end
  end
  if events == []
    puts "You have no events this week."
end
puts "Press any key to continue"
gets
end

def view_month
  events = []
  puts "Here are the months events."
  Event.all.each do |result|
    if result.start_date.month == Time.now.month &&
      results.start_date.year == Time.now.year
      puts result.description
      events << result.description
    end
  end
    if events == []
      puts "You have no events this month"
    end
  puts "Press any key to continue"
  gets
end




welcome
