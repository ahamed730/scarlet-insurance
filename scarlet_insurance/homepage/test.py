from dateutil import parser

date = "December 17 2022, 5:45  "
new_date = parser.parse(date)
print(new_date)