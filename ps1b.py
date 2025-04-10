## Collaborators:

##########################################################################################
## Get user input for yearly_salary, portion_saved, cost_of_dream_home, semi_annual_raise below ##
##########################################################################################
yearly_salary = float(input("Enter your yearly salary: "))
portion_saved = float(input("Enter the percent of your salary to save, as a decimal: "))
cost_of_dream_home = float(input("Enter the cost of your dream home: "))
semi_annual_raise = float(input("Enter the percent of your semi anual raise as a decimal:  "))



########################################################################
## Initialize other variables you need (if any) for your program below ##
#########################################################################
portion_down_payment=0.25  # 25% of the home price
r=0.05  # Annual rate of return
corrected_yearly=(yearly_salary)
monthly_salary=(yearly_salary / 12)  # Monthly salary
down_payment = cost_of_dream_home * portion_down_payment  # Total down payment needed
amount_saved = 0.0  # Starting with no savings
months = 0





###############################################################################################
## Determine how many months it would take to get the down payment for your dream home below ## 
###############################################################################################
while amount_saved < down_payment:
    # Add monthly savings (portion of monthly salary saved) and monthly return on current savings
    amount_saved += (amount_saved * r / 12) + (monthly_salary * portion_saved)
    
    # Every six months, apply the semi-annual raise
    if months % 6 == 0 and months > 0:
        monthly_salary *= (1 + semi_annual_raise)
    
    months += 1


# Output the result to the user
print(f"Number of months: {months}")