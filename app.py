import random
import time

min_val = 1
max_val = 6

while True:
	roll=(random.randint(min_val, max_val))
	with open('dice_results.txt', 'a') as f:
		f.write("The values are:")
		f.write(str(roll) + "\n")
	time.sleep(1)
