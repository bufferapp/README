# How we calculate monthly recurring revenue (MRR)
There are four gateways through which customers pay Buffer for its services: Stripe, Apple (iTunes), Android (Google Play), and manual payments. Each gateway has its unique properties and we calculate MRR for each individually. To report the final MRR value, we sum the MRR values from each gateway.


### Stripe
Stripe MRR is calculated with a series of SQL queries [here](https://github.com/bufferapp/buda-dbt/blob/master/models/mrr/stripe_mrr.sql). The basic idea is this: for any given date in a calendar year, we check all Stripe invoices that cover that specific date. For example, if we look only at the invoices in the table below, we could see that August 15 has been paid for by all five of these customers. Therefore, we would sum the monthly value of all five subscriptions to calculate MRR on August 15.


![](https://d2mxuefqeaa7sj.cloudfront.net/s_A7874576844CDF374224F87FB64E6AF9475B7AFD2B3CC88B459C0D49B853AAC2_1533066642599_Screen+Shot+2018-07-31+at+3.50.30+PM.png)


We do this for all dates and include all Stripe invoices. Note that as of August 2018, invoices _do not_ need to be paid for subscriptions' MRR values to be counted in MRR. The only requirement is that the subscription have at least one successful, non-zero, charge associated with it.


### Apple
Apple MRR is calculating by summing the value of active subscriptions on any given date. The number of subscriptions for each plan type and currency type are downloaded from Apple with this script.

For each date, plan ID, and customer currency, we collect the number of active subscriptions.

![](https://d2mxuefqeaa7sj.cloudfront.net/s_A7874576844CDF374224F87FB64E6AF9475B7AFD2B3CC88B459C0D49B853AAC2_1533068569547_Screen+Shot+2018-07-31+at+4.22.27+PM.png)


For currencies that are not USD, we apply the most recent exchange rate to get the subscriptions’ values in USD for each plan ID and date. For any given date, we sum the MRR values of subscriptions that were active on that date.


### Android
Android MRR is also calculated by summing the values of active subscriptions on any given date. We download a report from Google Play here. This is what the data looks like.

![](https://d2mxuefqeaa7sj.cloudfront.net/s_A7874576844CDF374224F87FB64E6AF9475B7AFD2B3CC88B459C0D49B853AAC2_1533068899687_Screen+Shot+2018-07-31+at+4.27.55+PM.png)


For any given date, we sum the MRR values of subscriptions that were active on that date.


### Manual Payments
Customers that are paying manually are collected from this spreadsheet.

![](https://d2mxuefqeaa7sj.cloudfront.net/s_A7874576844CDF374224F87FB64E6AF9475B7AFD2B3CC88B459C0D49B853AAC2_1533224909432_Screen+Shot+2018-08-02+at+11.48.16+AM.png)


[This R script](https://github.com/bufferapp/manual-payments/blob/master/manual_payments.R) processes the data. For any given date, we check to see if there is a paid invoice that includes the date in question. If so, we’ll include the MRR amount of that customer’s invoice.


### Total Daily MRR
To get a total MRR value for a given date, we simply sum the Stripe, Apple, Android, and Manual MRR for that date that we have already pre-calculated.
