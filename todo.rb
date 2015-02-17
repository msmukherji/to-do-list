require 'pry'
require 'colorize'
require './db/setup'
require './lib/all'

#class Dispatcher
  def add listname, todoitem
    a = List.find_or_create_by!(name: listname)
    b = Item.create!(name: todoitem, list_id: a.id, completed: "false")
  end

  def due n, time=nil
    a = Item.find_by!(name: n)
    a.due = Date.parse(time) # must enter date as YYYYMMDD
    a.save!
  end

  def done n
    a = Item.find_by!(name: n)
    a.completed = "true"
    a.save!
  end

  def list name=nil
    if name
      a = List.find_by!(name: name)
      b = Item.where(list_id: a.id, completed: "false")
      b.each { |x| puts "#{x.name}\t\t#{x.due}".underline} 
    else
      a = Item.where(completed: "false")
      a.each {|x| puts x.name}
    end
  end

  def list_all
    a = Item.all
    puts "Incomplete items are underlined:\n\n"
    a.each do |x| 
      if x.completed == "false"
        puts "#{x.name}\t\t#{x.due}".underline
      else
        puts "#{x.name}"
      end
    end
  end

  def next_item
    a = Item.all
    b = a.where.not(due: nil, completed: "true")
    if b.count > 0
      c = b.sample
    else
      c = a.sample
    end
    puts "#{c.name}\t\t#{c.due}"
  end

  def search n
    a = Item.all
    b = 0
    a.each do |x|
      if x.name.include? n
        b+=1
        puts "#{x.name}\t\t#{x.due}"
      end
    end
    unless b > 0
      puts "No items containing #{n}"
    end
  end
#end

command = ARGV.shift

# begin
#   Dispatcher.new.send command, *ARGV
# rescue NoMethodError
#   puts "Unrecognized command: #{command}"
# end
# ^^ better way that doesn't work yet here

case command

when "add"
  a = ARGV[0]
  b = ARGV[1]
  
  add a, b
when "due"
  a = ARGV[0]
  b = ARGV[1]

  due a,b
when "done"
  a = ARGV[0]
  done a
when "list"
  if ARGV.empty?
    list
  elsif ARGV[0] == "all"
    list_all
  else
    a = ARGV[0]
    list a
  end
when "next"
  next_item
when "search"
  a = ARGV[0]
  search a
else
  puts "Not a valid command."
end
