# 1. Loop over list of symbols to retrieve prices for
# 2. Check if ther are any historical prices available, if there is not: retrieve prices as far back as needed
# 2. Get historical prices from storage
# 4. Compare with todays date, if there might be new prices available, try to fetch them with StockFetcher
# 5. If we found any new prices, insert them into the storage
