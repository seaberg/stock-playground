# 1. Loop over list of symbols to retrieve prices for
# 2. Get historical prices from storage
# 3. Check the oldest price available in history and see if we need to retrieve prices from before this date.
#    this should be a setting (Default 600 days?)
# 4. Compare with todays date, if there might be new prices available, try to fetch them with StockFetcher
# 5. If we found any new prices, insert them into the storage
