def stock_picker(stock_days)    
    max = 0
    best = []
    #check each buy day (never last day)
    stock_days[0...-1].each_with_index do |buy_price, buy_day|
        sell_days = stock_days[buy_day + 1..]
        
        #check each sell day
        sell_days.each_with_index do |sell_price, sell_day|

            #test if selling on this day is best
            if (sell_price - buy_price > max)
                max = sell_price - buy_price
                best = [buy_day, buy_day + sell_day + 1]
            end
        end
        
    end
    
    best
end