# Payments Exercise

Add in the ability to create payments for a given loan using a JSON API call. You should store the payment date and amount. Expose the outstanding balance for a given loan in the JSON vended for `LoansController#show` and `LoansController#index`. The outstanding balance should be calculated as the `funded_amount` minus all of the payment amounts.

A payment should not be able to be created that exceeds the outstanding balance of a loan. You should return validation errors if a payment can not be created. Expose endpoints for seeing all payments for a given loan as well as seeing an individual payment.

## Routes

| Prefix | Verb | URI Pattern | Controller#Action |
|--|--|--|--|
| loan_payments | GET | /loans/:loan_id/payments | payments#index |
| | POST | /loans/:loan_id/payments | payments#create |
| loan_payment | GET | /loans/:loan_id/payments/:id | payments#show |
| loans | GET | /loans | loans#index |
| loan | GET | /loan/:id | loans#show |

## Notes

Directions didn't specify endpoints to create new loans or delete them. It would make sense for practical purposes. I thought maybe **loans#edit** could also be used, but ultimately left it out.