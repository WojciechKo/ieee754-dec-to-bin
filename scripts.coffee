$ ->
	$('#input-decimal').on('input',(event) -> print_details(event.target.value));
	
	print_details = (decimal) ->
		float = parseFloat(decimal)
		
		$(".decimal").text float
		sign = if float < 0.0 then 1 else 0
		$(".sign").text sign
		
		mantissa = Math.abs(float)
		exponent = 0
		until Math.abs(exponent) >= 127 || mantissa == 0 || isNaN(mantissa) || (mantissa >= 1 && mantissa < 2)
			while mantissa >= 2
				mantissa /= 2
				exponent++

			while mantissa < 1
				mantissa *= 2
				exponent--	
		exponent_str = ("00000000" + (exponent + 127).toString(2)).slice(-8)
		$(".exponent").text exponent
		$(".exponent-sum").text exponent + 127
		$(".exponent-bin").text exponent_str 
		
		table = $(".mantisa-table")
		table.empty()
		headers = $('<tr></tr>')
		headers.append $('<th></th>').text "Bit"
		headers.append $('<th></th>').text "Rest"
		headers.append $('<th></th>').text "Double rest"
		headers.append $('<th></th>').text "Value"
		headers.append $('<th></th>').text "Summation"
		table.append(headers)
		
		mantissa_rest = mantissa - 1
		iterator = 23
		mantissa_str = ''
		mantissa_part = 1
		summation = 0
		
		for i in [0...iterator] by 1
			row = $('<tr></tr>')
			mantissa_rest *= 2
			mantissa_part /= 2
			mantissa_rest_old = mantissa_rest
			if mantissa_rest >= 1
				mantissa_rest -= 1
				mantissa_str += 1
				summation += mantissa_part
				row.addClass "positive"
			else
				mantissa_str += 0
				
			row.append $('<td></td>').append($('<span></span>').addClass('mant').text(mantissa_str.slice(-1)))
			row.append $('<td></td>').text mantissa_rest_old / 2
			row.append $('<td></td>').text mantissa_rest_old
			row.append $('<td></td>').text mantissa_part
			if mantissa_str.slice(-1) == '0'
				row.append $('<td></td>').text(summation + mantissa_part).css('color', 'Red')
			else if mantissa_str.slice(-1) == '1'
				row.append $('<td></td>').text(summation)
			table.append(row)

		$(".mantissa").text mantissa
		$(".mantissa-bin").text mantissa_str
		
		$(".result").text "#{sign} #{exponent_str} #{mantissa_str}"
				
		exp = Math.pow(2, parseInt(exponent_str, 2) - 127)
		mant = 1
		temp = 1
		for i in [0...mantissa_str.length] by 1
			temp /= 2
			mant += temp if mantissa_str[i] == '1'
		
		from_bin = exp * mant
		from_bin *= -1 if sign == 1
			
		$(".decimal-from-bin").text from_bin
