require 'date'


# Adapted from:  http://snippets.dzone.com/posts/show/7109
#
# file: easter.rb

# ASP (rewritten in Ruby) Easter Calculation Library
#
# Copyright (c) 2008, reusablecode.blogspot.com; some rights reserved.
#
# This work is licensed under the Creative Commons Attribution License. To view
# a copy of this license, visit http://creativecommons.org/licenses/by/3.0/ or
# send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California
# 94305, USA.
#
# This function library allows calculation of the following ecclesiastical holidays:
# Ash Wednesday, Palm Sunday, Good Friday, Easter, Ascension Day, and Pentecost.
#
# Refer to Wikipedia for information on the purpose of these holidays..
# Determine the date of Easter for a given year.


class ReligiousFestival

    #Get the date for easter sunday given the year.
    def self.easter(some_year)

        golden_number = (some_year % 19) + 1
        day_of_calender_reform = 1752

        if some_year <= day_of_calender_reform then
            # Julian calendar
            dominical_number = (some_year + (some_year / 4) + 5) % 7
            paschal_full_moon = (3 - (11 * golden_number) - 7) % 30
        else
            # Gregorian calendar
            dominical_number = (some_year + (some_year / 4) - (some_year / 100) + (some_year / 400)) % 7
            solar_correction = (some_year - 1600) / 100 - (some_year - 1600) / 400
            lunar_correction = (((some_year - 1400) / 100) * 8) / 25
            paschal_full_moon = (3 - 11 * golden_number + solar_correction - lunar_correction) % 30
        end

        dominical_number += 7 until dominical_number > 0 
        paschal_full_moon += 30 until paschal_full_moon > 0 
        paschal_full_moon -= 1 if paschal_full_moon == 29 or (paschal_full_moon == 28 and golden_number > 11)
        difference = (4 - paschal_full_moon - dominical_number) % 7
        difference += 7 if difference < 0 
        day_easter = paschal_full_moon + difference + 1

        if day_easter < 11 then
            # Easter occurs in March.
            return Date.new(y=some_year, m=3, d=day_easter + 21)
        else
            # Easter occurs in April.
            return Date.new(y=some_year, m=4, d=day_easter - 10)
        end
    end
    
    
    
    
    # Determine the date of Good Friday for a given year.
    #
    def self.good_friday(some_year)
      easter(some_year) - 2
    end



    # Determine the date of Palm Sunday for a given year.
    #
    def self.palm_sunday(some_year)
      easter(some_year) - 7
    end



    # Determines the date of Ash Wednesday for a given year.
    #
    def self.ash_wednesday(some_year)
      easter(some_year) - 46
    end



    # Determines the date of Ascension Day for a given year.
    #
    def self.ascension_day(some_year)
      easter(some_year) + 39
    end



    # Determines the date of Pentecost for a given year.
    #
    def self.pentecost(some_year)
      easter(some_year) + 49
    end
    
    
    def self.whit_sunday(some_year)
        easter(some_year) + 49
    end
    
    
    def self.whit_monday(some_year)
        easter(some_year) + 50
    end
    
    
    # determine the date of Easter Monday for a given year
    #
    def self.easter_monday(some_year)
        easter(some_year) + 1
    end
end
    