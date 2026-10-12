Q1 — Which sources are batch and which is streaming? Why does the data team handle them differently? Which one is the fact and which are the dimensions?
Your answer:
 -> drivers.csv, vehicules.csv and zones.csv are batch , while rides is streaming 
 -> i am not sure what do u mean by handle them differently , but i think batch is reading a groupe of data at once so that is why we read them from a csv , while for the rides which is streaming we used INSERT to insert each streamed record in the rides table 
 -> since the vehicules,zonesand drivers has descriptive columns => dimension tables
 -> and the rides table has ids and calculated columns and represents an event that occur => its a fact table

Q2 — Is this pipeline ETL or ELT? Justify in 1-2 sentences, using the 3 layers.
Your answer:
 -> its ELT , since we read the data (extraction) from the sources for the batch sources and insert the streamed records for the streamed source, then we load them into postgres tables (load), then we apply the transfomration using dags that contain sql script to make the data clean for the staging area then calculate some KPIs for the mart area

Q3	Write the grain of mart.rides in one sentence: "one row = ...".
 -> one row = one ride

Q4	staging.zones is joined twice in mart.rides. What do we call this pattern? Why not make two zone tables?
 -> we cal this pattern *role-playing dimensions*
 -> Both roles refer to the same set of zones, so separate tables are unnecessary.

Q5	How many rides are in raw.rides, in staging.rides? Where did the others go? Why is filtering in staging better than letting the JOIN in the mart drop them silently?


Q6	You re-run 3_staging three times. Why is there no duplicate? What would happen if the SQL used INSERT INTO instead of DROP + CREATE TABLE 
AS?
 -> by droping the tables before inserting new data, we apply what we call idempontency , to make the data consistent and reliable no matter how much we re-run the script or the task
 -> using INSERT INTO without droping will append the new data to the previous data which will create duplicates

Q7	Is fare_amount additive, semi-additive or non-additive? And rating? What would be wrong with SUM(rating)?
 ->fare_amount is additive because we can calculate the sum of it across all dimensions , while rating is not a measure so adding it up does not make any sense

Q8	The back office changes a driver's rating in drivers.csv and 2_batch reloads it. What happens to the old rides of this driver in mart.
rides? Is it correct for InDrive? Which technique would keep the rating the driver had at the time of the ride?
 -> the old rides will be droped as I DROP the table before inserting new coming data
 -> no , its not the correct approach , slowly changing dimensions would be the correct approch to preserve the previous ratings and adding a column that tells whether its the current rating or not