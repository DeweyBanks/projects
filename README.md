# PROJECTS -
> A way to calculate project cost
---
## Data Setup

### WorkSet:
   - has a schedule
   - has many projects
   - has a reimbursement amount

 ### Project:
   - belongs to a WorkSet
   - belongs to a schedule through Set
   - has a start date
   - has an end date
   - has a city enumeration of 'Low' or 'High'

 ### Schedule:
   - belongs to a WorkSet
   - has many projects through WorkSet
   - has travel days
   - has full days

-------
## USE:
1. Requirements:
   - ruby 2.6.3
2. Run the app
   - `ruby app.rb`
