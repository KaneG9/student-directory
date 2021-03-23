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
  name = gets.chomp
  while !name.empty? do 
    puts "Enter cohort start month"
    cohort = gets.chomp.to_sym
    cohort = "N/A" if cohort.empty?
    puts "Enter #{name}'s country of birth"
    country = gets.chomp
    country = "N/A" if country.empty?
    puts "Enter #{name}'s height"
    height = gets.chomp
    height = "N/A" if height.empty?
    @students << { name: name, cohort: cohort, country: country, height: height }
    @students.count == 1 ? (puts "Now we have #{@students.count} student") : (puts "Now we have #{@students.count} students")
    puts "Enter next student's name"
    name = gets.chomp
  end
  @students
end

def print_letter(names, letter)
  names.each_with_index { |name, ind| puts "#{ind + 1}. #{name[:name]} (#{name[:cohort]} cohort)".center(100) if name[:name][0].downcase == letter.downcase}
end

def print_length(names, length)
  names.each_with_index { |name, ind| puts "#{ind + 1}. #{name[:name]} (#{name[:cohort]} cohort)".center(100) if name[:name].length < length}
end

def info(name, students)
  students.each do |student|
    if student[:name] == name
      puts "#{student[:name]}:".center(100)
      puts "Cohort: #{student[:cohort]}".center(100)  
      puts "Height: #{student[:height]}".center(100)  
      puts "Country of birth: #{student[:country]}".center(100)  
    end
  end
end
      
  
def each_to_while(names)
  acc = 0
  while acc < names.length
    puts "#{acc + 1}. #{names[acc][:name]} (#{names[acc][:cohort]} cohort)"
    acc += 1
  end
end

def group_by_cohort(students)
  students.group_by { |student| student[:cohort] }.each do |cohort, members|
    members.each { |person| puts "#{person[:name]} (#{person[:cohort]} cohort)".center(100)}
  end
end

def print_menu
  puts "1. Input students"
  puts "2. Show students"
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
    when "9"
      exit
    else 
      puts "Please enter a number and try again"
  end
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

#can replace .chomp with [0..-2]

interactive_menu

