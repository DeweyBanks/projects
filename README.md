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



---
***
___

The Challenge

You have a set of projects, and you need to calculate a reimbursement amount for the set. Each project has a start date and an end date. The first day of a project and the last day of a project are always "travel" days. Days in the middle of a project are "full" days. There are also two types of cities a project can be in, high cost cities and low cost cities.

A few rules:
First day and last day of a project, or sequence of projects, is a travel day.
Any day in the middle of a project, or sequence of projects, is considered a full day.
If there is a gap between projects, then the days on either side of that gap are travel days.
If two projects push up against each other, or overlap, then those days are full days as well.
Any given day is only ever counted once, even if two projects are on the same day.
A travel day is reimbursed at a rate of 45 dollars per day in a low cost city.
A travel day is reimbursed at a rate of 55 dollars per day in a high cost city.
A full day is reimbursed at a rate of 75 dollars per day in a low cost city.
A full day is reimbursed at a rate of 85 dollars per day in a high cost city.

Given the following sets of projects, provide code that will calculate the reimbursement for each.

Set 1:
  Project 1: Low Cost City Start Date: 9/1/15 End Date: 9/3/15

Set 2:
  Project 1: Low Cost City Start Date: 9/1/15 End Date: 9/1/15
  Project 2: High Cost City Start Date: 9/2/15 End Date: 9/6/15
  Project 3: Low Cost City Start Date: 9/6/15 End Date: 9/8/15

Set 3:
  Project 1: Low Cost City Start Date: 9/1/15 End Date: 9/3/15
  Project 2: High Cost City Start Date: 9/5/15 End Date: 9/7/15
  Project 3: High Cost City Start Date: 9/8/15 End Date: 9/8/15

Set 4:
  Project 1: Low Cost City Start Date: 9/1/15 End Date: 9/1/15
  Project 2: Low Cost City Start Date: 9/1/15 End Date: 9/1/15
  Project 3: High Cost City Start Date: 9/2/15 End Date: 9/2/15
  Project 4: High Cost City Start Date: 9/2/15 End Date: 9/3/15
