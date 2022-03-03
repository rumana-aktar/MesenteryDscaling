function digit = getNextDigit(I, topLeft_x, topLeft_y, digit_width, digit_height)
    
    digit = I(topLeft_y : topLeft_y + digit_height, topLeft_x : topLeft_x + digit_width);
end

