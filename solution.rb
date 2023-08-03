# Heartland Coding Challenge
# Author: Nolan Shepherd
# Date: 2023-08-02

require 'time'

# Function to organize and rename photos
# Time complexity: O(n log n)
def solution(s)
  
  # Splitting input strings and parsing each line
  photos = s.split("\n").map do |line|
    # Skip if line is empty (bad input)
    next if line.strip.empty?

    photo_name, city_name, date_time = line.split(', ')
    extension = photo_name.split('.').last

    # Constructing an array for each photo with its metadata
    [city_name, Time.parse(date_time), "#{photo_name.gsub('.','')}.#{extension}", photo_name]
  end.compact 

  # Group photos by city name
  grouped_photos = photos.group_by { |photo| photo[0] }

  renamed_photos = Array.new(photos.length)

  # Iterating over each group of photos
  grouped_photos.each do |city, city_photos|
    # Sorting by date and time
    city_photos.sort_by! { |photo| photo[1] }

    # Calc length of the biggest number within group
    num_length = city_photos.length.to_s.length

    # Renaming the photos
    city_photos.each.with_index(1) do |photo, idx|
        new_name = city + idx.to_s.rjust(num_length, '0') + '.' + photo[2].split('.').last
        renamed_photos[photos.index { |p| p[3] == photo[3] }] = new_name
    end
  end

  # Combine array of renamed photos into a final output
  renamed_photos.join("\n")
end

# Read the input string from file
input_string = File.read('input.txt')

# Call func with file input 
puts solution(input_string)

