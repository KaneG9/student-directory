@students = []

def print_header
  puts ("The students of Villains Academy".center(100))
  puts "-------------".center(100)
end

def print_student_list
  @students.each_with_index { |name, ind| puts ("#{ind + 1}. #{name[:name]} (#{name[:cohort]} cohort)".center(100)) }
end

def print_footer
  @students.count == 1 ? (puts "Overall, we have #{@students.count} great student".center(100)) : 
                         (puts "Overall, we have #{@students.count} great students".center(100))
  puts "-------------".center(100)
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice."
  name = STDIN.gets.chomp
  while !name.empty? do 
    puts "Enter cohort start month:"
    cohort = STDIN.gets.chomp
    add_student(name, cohort)
    puts "#{name} was added. Now we have #{@students.count} student#{@students.count == 1 ? "" : "s"}."
    puts "Enter next student's name:"
    name = STDIN.gets.chomp
  end
end

def print_menu
  puts "1. Input students"
  puts "2. Show students"
  puts "3. Save the students to (deafult = students.csv)"
  puts "4. Load students from (default = students.csv)"
  puts "9. Exit"
end

def show_students
  print_header
  print_student_list
  print_footer
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit
    else 
      puts "Please enter a number from the list and try again"
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def save_students
  filename = choose_file("save to")
  File.open(filename, "w") do |file|
    count = 0
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv_line = student_data.join(",")
      file.puts csv_line
      count += 1
    end
    puts "#{count} student#{count == 1 ? " was" : "s were"} saved to #{filename}"
  end
end

def load_students(filename = "students.csv")
  filename = choose_file("load from")
  File.open(filename, "r") do |file|
    file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    add_student(name, cohort)
    end
  puts "Data successfully loaded from #{filename}"
  end
end

def choose_file(from)
  puts "Enter file to #{from} (press enter for default):"
  filename = STDIN.gets.chomp
  filename = "students.csv" if filename.empty?
  filename
end

def startup_load_students
  filename = ARGV.first #first commandline arg
  filename = "students.csv" if filename.nil? #autoload students.csv if no file is given
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} student#{@students.count == 1 ? "" : "s"} from #{filename}"
  else
    puts "Sorry, #{filename} does not exist."
    exit
  end
end

def add_student(name, cohort)
  @students << { name: name, cohort: cohort.to_sym }
end

startup_load_students
interactive_menu


