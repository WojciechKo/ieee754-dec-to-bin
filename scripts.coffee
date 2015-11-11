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
		
		temp = mantissa - 1
		iterator = 23
		mantissa_str = ''
		while iterator > 0
			temp *= 2
			iterator--
			if temp >= 1
				temp -= 1
				mantissa_str += 1
			else
				mantissa_str += 0
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
