# ATM_assembly
Task:
In ATM machine, an electronic lock circuit is used to authorize the card. This circuit has two
input codes: The card number that consists of 16 bits and the password that consists of 4 bits.
If the bank has 20 customers only uses the cards. Construct their database and store it in the
memory. Then write a program for card authorization.
The inputs of the program are the card number and the password.
The output is one bit (0/1) that means (denied/allowed).

## Sample Runs
![image](https://github.com/elmahygurl/ATM_assembly/assets/97133077/0d038bf2-f205-43cf-a7bf-16597a16a588)
![image](https://github.com/elmahygurl/ATM_assembly/assets/97133077/ba700393-9e4e-474e-8892-b838017ce1bb)
![image](https://github.com/elmahygurl/ATM_assembly/assets/97133077/d2b914f6-8dde-4653-bc32-bf1ca25786d6)
## Comments:
•	Prints “Access denied” when a wrong card number has been entered.
•	Prints “Incorrect Passcode” when the passcode entered does not match the card number that was previously entered.
•	SI Register is used as index.
