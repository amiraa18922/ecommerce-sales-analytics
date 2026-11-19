# E-Commerce Sales Analytics | SQL • Python • Power BI

## Project Overview

An end-to-end data analytics portfolio project exploring e-commerce sales performance, customer behaviour, customer retention and revenue growth.

The project demonstrates the use of **Excel, SQL, Python (Pandas) and Microsoft Power BI** to transform raw transactional data into actionable business insights through data cleaning, analytical queries, KPI calculations and interactive dashboards.

The objective is to help an e-commerce business understand its sales performance, identify customer purchasing patterns, monitor revenue trends and support data-driven decision-making.

## Tools & Technologies

| Tool | Application |
|---|---|
| Microsoft Excel | Initial dataset inspection |
| SQL | Data querying, aggregation and business analysis |
| Python (Pandas) | Data cleaning, transformation and preparation |
| Power BI | Data modelling, DAX measures and interactive dashboards |
| GitHub | Version control, documentation and portfolio presentation |

## Business Objectives

This project explores the following business questions:

1. How is overall sales revenue performing?
2. Which product categories generate the most revenue?
3. How does revenue change month-over-month and year-over-year?
4. What are the purchasing behaviours of different customer segments?
5. How frequently do customers make repeat purchases?
6. How do customer retention and churn change over time?
7. How does customer satisfaction vary across transactions?
8. What opportunities exist to improve customer retention and business performance?

## Project Workflow

### 1. Data Preparation and Cleaning — Python

Python and Pandas were used to prepare the e-commerce dataset for analysis.

The cleaning workflow included:

- Loading the raw e-commerce dataset.
- Standardising column names using lowercase snake_case.
- Identifying and removing duplicate records.
- Handling missing values.
- Replacing missing quantity values with zero.
- Replacing missing unit prices with the median unit price.
- Exporting the cleaned dataset for further analysis.

**Files:**
- `data_cleaning.py`
- `cleaned_ecommerce_data.csv`

### 2. Data Analysis — SQL

SQL was used to analyse transactional data and calculate business performance metrics.

The analysis covered:

- Total orders and revenue.
- Average order value.
- Monthly sales performance.
- Month-over-month revenue growth.
- Revenue by product category.
- Customer purchasing behaviour.
- Customer segmentation.
- Customer ratings and discount analysis.

SQL techniques demonstrated include filtering, aggregation, grouping, sorting and analytical calculations.

**SQL file:** `relational_queries.sql`

### 3. Data Visualisation — Power BI

An interactive three-page Power BI report was developed to communicate key business findings.

DAX measures were used to calculate performance indicators, including revenue growth, customer retention and repeat purchase metrics.

The dashboard includes interactive filters, KPI cards, trend charts, category comparisons and customer-level analysis.

## Power BI Dashboard

### Dashboard 1 — Sales Overview

![Sales Overview](Sales%20Overview.png)

Provides an overview of sales performance and key business metrics.

Focus areas include overall sales, revenue performance, product categories and purchasing activity.

### Dashboard 2 — Customer Performance & Retention

![Customer Performance and Retention](Customer%20Performance%20and%20Retention.png)

Examines customer behaviour, repeat purchases, satisfaction and retention.

Key results from the overall customer analysis:

| Metric | Result |
|---|---:|
| Total Customers | 989 |
| Repeat Customers | 950 |
| Repeat Purchase Rate | 96.06% |
| Average Orders per Customer | 5.06 |

Additional analysis includes customer segmentation, geographic purchasing patterns, top-spending customers and annual retention trends.

Retention and churn metrics are evaluated using year-specific customer cohorts rather than interpreting an unfiltered, all-years total as a single annual churn rate.

### Dashboard 3 — Revenue Growth & Business Insights

![Revenue Growth and Business Insights](Revenue%20Growth%20and%20Business%20Insights.png)

Examines monthly revenue trends, year-over-year growth and product category performance.

**Example: 2023 revenue analysis**

| Metric | Result |
|---|---:|
| Total Revenue | £365,915.79 |
| Previous Year Revenue | £371,824.30 |
| Year-over-Year Growth | -1.59% |
| December Monthly Growth | -11.04% |

The report also includes monthly revenue comparisons, revenue changes, category-level growth and dynamic business insight summaries.

## Key Business Insights

### 1. Customer Repeat Purchasing

Across the full dataset, 950 out of 989 customers made repeat purchases, representing a repeat purchase rate of approximately 96.06%.

This indicates substantial repeat purchasing activity within the analysed dataset.

### 2. Revenue Performance

In 2023, total revenue reached approximately £365.92K, compared with £371.82K in the previous year.

This represents a year-over-year decline of approximately 1.59%.

### 3. Product Category Performance

Electronics generated approximately £124,799 in revenue during 2023, making it the leading revenue-generating category in the selected year.

However, the category experienced a year-over-year decline of approximately 5.32%.

### 4. Customer Retention

Annual retention analysis highlights changes in the proportion of customers returning from the previous year.

These findings help identify periods where customer re-engagement may require additional attention.

### 5. Revenue Volatility

Monthly revenue growth fluctuated throughout 2023, including an 11.04% decline in December compared with November.

These fluctuations highlight the importance of monitoring monthly performance alongside annual revenue totals.

## Business Recommendations

Based on the dashboard findings, the following actions could be investigated:

**Improve customer retention:** Examine the characteristics of customers who do not return and consider targeted re-engagement campaigns.

**Investigate category declines:** Review Electronics and other declining categories to identify possible pricing, demand or product-mix factors.

**Monitor monthly revenue changes:** Investigate months with substantial revenue declines and compare them with marketing activity, promotions and customer demand.

**Use customer segmentation:** Explore tailored marketing strategies for
