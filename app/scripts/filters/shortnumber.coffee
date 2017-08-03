'use strict'

###*
 # @ngdoc filter
 # @name dgsDash.filter:shortnumber
 # @function
 # @description
 # # shortnumber
 # Filter in the dgsDash.
###
angular.module 'dgsDash'
    .filter 'shortnumber', ->
        (number, decPlaces=2) ->
            # 2 decimal places => 100, 3 => 1000, etc
            decPlaces = 10 ** decPlaces
            # Enumerate number abbreviations
            abbrev = [
                'k'
                'm'
                'b'
                't'
            ]
            # Go through the array backwards, so we do the largest first
            i = abbrev.length - 1
            while i >= 0
                # Convert array index to "1000", "1000000", etc
                size = 10 ** ((i + 1) * 3)
                # If the number is bigger or equal do the abbreviation
                if size <= number
                    # Here, we multiply by decPlaces, round, and then divide by decPlaces.
                    # This gives us nice rounding to a particular decimal place.
                    number = Math.round(number * decPlaces / size) / decPlaces
                    # Handle special case where we round up to the next abbreviation
                    if number == 1000 and i < abbrev.length - 1
                        number = 1
                        i++
                    # Add the letter for the abbreviation
                    number += abbrev[i]
                    # We are done... stop
                    break
                i--

            number
