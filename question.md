# 📘 SQL Practice Questions – Beginner to Advanced

These questions progressively increase in complexity and cover core SQL concepts such as querying, joins, subqueries, CTEs, window functions, and optimization strategies.

---

## 🟦 A. Basic to Intermediate Queries (SELECT, WHERE, ORDER BY, GROUP BY, HAVING, JOINS)

1. **Retrieve all customer details**  
   _→ Select all columns from the `Customers` table._

2. **List products in the 'Electronics' category**  
   _→ Select `ProductName`, `UnitPrice` where `Category = 'Electronics'`._

3. **Find orders placed in February 2024**  
   _→ Select `OrderID`, `CustomerID`, and `OrderDate` for February 2024._

4. **Total products in stock by category**  
   _→ Group by `Category` and sum `StockQuantity`._

5. **Customers with more than 1 order**  
   _→ Count orders per `CustomerID` and filter count > 1._

6. **Products costing > $100 with > 50 units in stock**  
   _→ Use `WHERE` clause on `UnitPrice` and `StockQuantity`._

7. **Customer names and order IDs**  
   _→ Join `Customers` and `Orders`._

8. **Product names and number of times ordered**  
   _→ Join `Products` and `OrderItems`. Use appropriate `JOIN` to include products never ordered._

9. **Total revenue by product category**  
   _→ Join `Products` and `OrderItems`, then group by `Category`._

10. **Total amount spent by each customer**  
    _→ Join `Customers`, `Orders`, `OrderItems`; compute `SUM(Quantity * ItemPrice)`._

11. **Employees and their managers**  
    _→ Use a self-join on the `Employees` table (include those without managers)._

---

## 🟪 B. Subqueries & Common Table Expressions (CTEs)

1. **Product with highest price**  
   _→ Use subquery with `MAX(UnitPrice)`._

2. **Customers who purchased 'Laptop Pro X'**  
   _→ Subquery on `OrderItems`, filter by product, then match `CustomerIDs`._

3. **Orders with >1 unique product**  
   _→ Subquery counting `DISTINCT ProductID` per `OrderID`._

4. **Average order value**
   - **Subquery version**: SUM per `OrderID`, then average the sums.
   - **CTE version**: Use a CTE to calculate totals first.

5. **Top 3 most expensive products**  
   _→ Use subquery with `LIMIT`, `TOP`, or ranking._

6. **Employees earning more than department average**  
   _→ CTE that calculates avg salary per department._

7. **Customers with total order value > $500**  
   _→ Use CTE with grouped totals._

---

## 🟩 C. Window Functions

1. **Rank products by price within category**  
   _→ Use `RANK()` or `DENSE_RANK()` with `PARTITION BY Category`._

2. **Second most expensive product in each category**  
   _→ Use ranking functions with filtering._

3. **Running total of order amounts per customer**  
   _→ Use `SUM(...) OVER (PARTITION BY CustomerID ORDER BY OrderDate)`._

4. **Previous order date per customer**  
   _→ Use `LAG(OrderDate)`._

5. **Average salary by department (without grouping)**  
   _→ Use `AVG(Salary) OVER (PARTITION BY Department)`._

6. **3rd oldest order date per customer**  
   _→ Use `NTH_VALUE(OrderDate, 3)`._

7. **Orders with quantity > average quantity**  
   _→ Use window function for average and compare per row._

---

## 🟥 D. Data Manipulation & Advanced Concepts

1. **Customers who ordered and returned items**  
   _→ Use `INTERSECT` or subqueries on `Orders` and `Returns`._

2. **All customers + their OrderID (if any)**  
   _→ Use `LEFT JOIN` on `Orders`._

3. **All products + ReturnDate (if any)**  
   _→ Use `LEFT JOIN` on `Returns`._

4. **OrderItems from cancelled orders**  
   _→ Filter `OrderItems` where related order status = 'Cancelled'._

5. **Duplicate emails in `Customers`**  
   _→ Use `GROUP BY Email HAVING COUNT(*) > 1`._

6. **Pivot sales data from rows to columns**  
   _→ Use `CASE` statements or `PIVOT()` function._

7. **Find missing OrderIDs in sequence**  
   _→ Use `LEAD()`/`LAG()` or `JOIN` against a numbers table._

---

## ⚙️ E. Performance Tuning & Optimization (Conceptual)

1. **Clustered vs. Non-Clustered Index**  
   _→ Clustered = sorted storage, only one per table; Non-clustered = separate structure._

2. **Diagnosing slow queries**  
   _→ Use `EXPLAIN`/`ANALYZE`, review indexing, avoid `SELECT *`, rewrite queries._

3. **ACID properties**  
   - **Atomicity**: All or nothing  
   - **Consistency**: Valid state transitions  
   - **Isolation**: No interference  
   - **Durability**: Persisted after commit

4. **Normalization (1NF, 2NF, 3NF, BCNF)**  
   _→ Avoid redundancy, maintain data integrity._

5. **Denormalization use-cases**  
   _→ For read-heavy apps or analytics; trade-off = redundancy and maintenance._

6. **Handling complex queries on large tables**  
   _→ Use indexing, partitioning, materialized views, or caching._

7. **Handling NULLs**  
   _→ `NULL != NULL`; use `IS NULL`, impacts `COUNT`, `AVG`, comparisons._

8. **DELETE vs. TRUNCATE vs. DROP**
   - `DELETE`: Row-wise, can be filtered  
   - `TRUNCATE`: Fast full delete, minimal logging  
   - `DROP`: Removes entire table structure

---


### 🔧 Setup 
- Set up SQL environment (e.g., PostgreSQL, MySQL, SQLite).
- Create sample schema and insert basic test data.
- Run `SELECT *` queries to validate setup.

### 📘 A & B: Core SQL Practice 
- Focus on mastering joins, filtering, grouping.
- Compare subquery vs. join logic.

### 🎯 C: Window Functions 
- Essential for analytics/engineering interviews.
- Practice `RANK()`, `LAG()`, `OVER()`, `PARTITION BY`.

### 💡 D & E: Conceptual & Edge Cases 
- Prepare to **explain** advanced concepts.
- Write notes on trade-offs and optimization strategies.

---

## ✅ Tips for Self-Correction

- **Break complex queries** into smaller parts.
- **Use intermediate SELECTs** to debug logic.
- **Think about edge cases**: NULLs, empty sets, duplicates.
- **Check query plans** for optimization if supported.
- **Test on small datasets** to validate output manually.