# PROJECTS -
> A simple ruby program to calculate project cost
---
## Data Model

### WorkSet:
   - has a schedule
   - has many projects
   - has a reimbursement amount

 ### Project:
   - belongs to a WorkSet
   - belongs to a schedule through WorkSet
   - has a start date
   - has an end date

 ### Schedule:
   - belongs to a WorkSet
   - has many projects through WorkSet
   - has travel days
   - has full days
   - has an enumeration of TRAVEL_DAY_COST & FULL_DAY_COST, values: 'Low' or 'High'

-------
## USE:
1. Requirements:
   - ruby 2.6.3
2. Run Test:
   - `ruby test/projects_test.rb`
3. Run the app from root directory `/projects`
   - `ruby app.rb`


## How it works:

  - A WorkSet is created by reading data from json files stored in the projects-data folder.
   These files have restrictions.
    1. The files must be json files.
    2. The file names must be unique.
    3. The json objects contained within hold information for the Projects associated with a WorkSet.
     - The json is stored as an array of hashes:
     #### keys:
      - "city" -> Required: String, accepted values: high or low
      - "start_date" -> Required: String, Date "Month/Day/Year"
      - "end_date" -> Required: String, Date "Month/Day/Year"
     example:

     ```json
     [
        {
          "city": "low",
          "start_date": "9/1/15",
          "end_date": "9/3/15"
        }
     ]

     ```
  - When a WorkSet is created it creates the Projects pulled from the set file and from these creates a Schedule with a cost for the entire set.

