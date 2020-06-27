---
layout: post
title: "Business logic"
date: 2019-08-18 17:50:00 -0300
tags: system-design
---

In software architecture, the business logic layer contains classes that implement application specific business rules, typically made available in the form of high level operations, also known as **use cases**. The use cases encapsulate interactions between **entities**, which are reusable lower level logical models of the real-world business domain.

Code Examples
============

Use cases have an unidirectional many-to-many relationship to entities, for instance, consider the two use cases below for an illustrative banking application:

```csharp
public class GetAccountBalanceUseCase : UseCase
{
    public GetAccountBalanceUseCase(
        BankAccountIdentityProvider indentityProvider,
        BankAccountIndex accounts)
    {
        this.indentityProvider = indentityProvider;
        this.accounts = accounts;
    }

    public GetAccountBalanceOutput Execute(GetAccountBalanceInput input)
    {
        indentityProvider.Authenticate(
            input.AuthenticationToken,
            input.AccountNumber
        );

        BankAccount account = accounts.Get(input.AccountNumber);

        return new GetAccountBalanceOutput
        {
            Balance = account.GetBalance();
        };
    }

    private BankAccountIdentityProvider indentityProvider;

    private BankAccountIndex accounts;
}
```

```csharp
public class TransferFundsUseCase : UseCase
{
    public TransferFundsUseCase(
        TransactionScopeProvider transactionScope,
        BankAccountIdentityProvider indentityProvider,
        BankAccountIndex accounts,
        Ledger ledger)
    {
        this.transactionScope = transactionScope;
        this.indentityProvider = indentityProvider;
        this.accounts = accounts;
        this.ledger = ledger;
    }

    public TransferFundsOutput Execute(TransferFundsInput input)
    {
        indentityProvider.Authenticate(
            input.AuthenticationToken,
            input.SendingAccountNumber
        );

        using (transactionScope.Begin())
        {
            BankAccount sender = accounts.Get(input.SendingAccountNumber);
            BankAccount receiver = accounts.Get(input.ReceivingAccountNumber);

            sender.Withdraw(input.Amount);
            receiver.Deposit(input.Amount);

            ledger.Insert(from: sender, to: receiver, amount: input.Amount);

            return TransferFundsOutput
            {
                SenderBalance = sender.GetBalance();
                ReceiverBalance = receiver.GetBalance();
            };
        }
    }

    private TransactionScopeProvider transactionScope;

    private BankAccountIdentityProvider indentityProvider;

    private BankAccountIndex accounts;

    private Ledger ledger;
}
```

Both of them depend on up to four business entities for implementing workflows for querying an account's balance and transferring funds from one account to another:

* **BankAccountIdentityProvider**: Responsible for ensuring that the agent executing the operation has adequate permissions for managing the bank account

* **BankAccountIndex**: Responsible for fetching bank account entities according to their account number

* **BankAccount**: Responsible for providing functionalities on the level of an individual bank account

* **Ledger**: Responsible for recording economic transactions

Notice that a `TransactionScopeProvider` class is also present in the `TransferFundsUseCase` implementation, however it's not a business entity, it's an infrastructure component instead, determining the behavior of underlying data retrieval and persistence operations, and its specific implementation is irrelevant in this scope.

Layered Architecture
============

The business logic layer has no knowledge of infrastructure and operational details, such as which specific web server, message broker or database system are chosen for deploying the application. For greater flexibility and cohesion, all of these decisions are made at the outermost layer of the application, and required functionality is injected into the business logic layer with the assistance of a [dependency injection strategy]({{ site.baseurl }}/2019/07/integrating-third-party-modules).

<p align="center">
  <img style="max-height: 300px; max-width: 100%; margin: 10px 0" src="{{ site.baseurl }}/images/p6/clean-architecture.JPG" alt="clean-architecture"/>
  <br><label style="font-size: 12px;">figure 1</label>
</p>

The figure borrows from [Uncle Bob's clean architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) and demonstrates how business logic should be isolated from external dependencies to prevent leaking infrastructure logic to the business layer, achieving a clear separation of concerns that greatly benefits software development quality and productivity in the long-term.

The conversion logic layer is where Models, Views, Controllers, Presenters and integrations lie. It is responsible for converting data to the most convenient format inwards and outwards.

Finally, the infrastructure layer is where the application is hosted, specific UI and web frameworks are employed, and database and messaging systems are configured and interfaced.

---

In this short article I provide code examples for implementing use cases with the sole purpose of illustrating business logic concepts. I employ one of many different use case formats, a format which I have successfully applied in professional projects. 