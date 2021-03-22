def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_list(names)
  names.each { |name| puts "#{name[:name]} (#{name[:cohort]} cohort)" }
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

def input_students
  puts "Please enter the naems of the students"
  puts "To finish, just hit return twice"
  students = []
  name = gets.chomp
  while !name.empty? do 
    students << { name: name, cohort: :november }
    puts "Now we have #{students.count} students"
    name = gets.chomp
  end
  students
end

students = input_students
print_header
print_list(students)
print_footer(students)

