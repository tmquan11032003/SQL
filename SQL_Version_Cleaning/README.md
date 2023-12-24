## Requirements/Information

**Convert a table of metrics into a Version history table**

- We need to convert the contents of the `data.csv` file into the contents of the `finalData.csv` file
- Version1 is a major software update
- Version2 is a minor software update

**Desired Final Format**
| deviceID | dateTime   | Version1 | Version2 |
|----------|------------|----------|----------|
| A        | 2021-01-01 | 1.0      | A1       |
| A        | 2021-01-02 | 1.0      | A2       |
| B        | 2022-01-01 | 3.0      | A4       |

My solution uses:
* The `PIVOT` operator
* `WITH` to create a Continuous Table Expression (CTE)
* `OVER` to use window functions
