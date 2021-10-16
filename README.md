# PROJECTS -
> A way to calculate project cost
---
## Data Setup

### Set:
 has a schedule
 has many projects
 has a reimbursement amount

 ### Project:
  belongs to a Set
  belongs to a schedule through Set
  has a start date
  has an end date
  has a city enumeration of 'Low' or 'High'

 ### Schedule:
  belongs to a Set
  has many projects through Set
  has travel days
  has full days

-------
## USE:
1. Requirements:
   - ruby 2.6.3
2. Run the app
   - `ruby app.rb`
