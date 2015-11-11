// Generated by CoffeeScript 1.10.0
(function() {
  $(function() {
    var print_details;
    $('#input-decimal').on('input', function(event) {
      return print_details(event.target.value);
    });
    return print_details = function(decimal) {
      var exponent, exponent_str, float, iterator, mantissa, mantissa_str, sign, temp;
      float = parseFloat(decimal);
      $(".decimal").text(float);
      sign = float < 0.0 ? 1 : 0;
      $(".sign").text(sign);
      mantissa = Math.abs(float);
      exponent = 0;
      while (!(Math.abs(exponent) >= 127 || mantissa === 0 || isNaN(mantissa) || (mantissa >= 1 && mantissa < 2))) {
        while (mantissa >= 2) {
          mantissa /= 2;
          exponent++;
        }
        while (mantissa < 1) {
          mantissa *= 2;
          exponent--;
        }
      }
      exponent_str = ("00000000" + (exponent + 127).toString(2)).slice(-8);
      $(".exponent").text(exponent);
      $(".exponent-sum").text(exponent + 127);
      $(".exponent-bin").text(exponent_str);
      temp = mantissa - 1;
      iterator = 23;
      mantissa_str = '';
      while (iterator > 0) {
        temp *= 2;
        iterator--;
        if (temp >= 1) {
          temp -= 1;
          mantissa_str += 1;
        } else {
          mantissa_str += 0;
        }
      }
      $(".mantissa").text(mantissa);
      $(".mantissa-bin").text(mantissa_str);
      $(".result").text(sign + " " + exponent_str + " " + mantissa_str);
      return $(".confirmation").text(float + " = " + mantissa + " * 2^" + exponent);
    };
  });

}).call(this);