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
  puts "To finish, just hit return twice"
  name = STDIN.gets.chomp
  while !name.empty? do 
    puts "Enter cohort start month"
    cohort = STDIN.gets.chomp
    cohort = "N/A" if cohort.empty?
    add_student(name, cohort)
    @students.count == 1 ? (puts "Now we have #{@students.count} student") : (puts "Now we have #{@students.count} students")
    puts "Enter next student's name"
    name = STDIN.gets.chomp
  end
  @students
end

def print_menu
  puts "1. Input students"
  puts "2. Show students"
  puts "3. Save the list to students.csv"
  puts "4. Load students from students.csv"
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
      puts "Please enter a number and try again"
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    add_student(name, cohort)
  end
  file.close
end

def try_load_students
  filename = ARGV.first #first commandline arg
  filename = "students.csv" if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} students from #{filename}"
  else
    puts "Sorry, #{filename} does not exist."
    exit
  end
end

def add_student(name, cohort)
  @students << { name: name, cohort: cohort.to_sym }
end

try_load_students
interactive_menu


