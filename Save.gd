extends Node2D

var data = "user://playerdata.csv" # Generic path to user data that always works, playerdata is an arbitrary name for the file we are saving our data to.
var file2Check = File.new() # Creates a blank file class object we can use to detect if player data already exists or not.
var doFileExists = file2Check.file_exists(data) # This saves the result of a path check to see if our player data exists or not. We can use this to decide if we are going to create a new CSV or write to and existing one.
func _ready(): # This code executes once the program starts.
	if doFileExists == true: # Check if the csv already exists or not.
		pass # Do nothing if it does exist.
	else:# If it does not exist, do this.
		var file = File.new() # create a blank file class we can write data to.  
		file.open(data, File.WRITE) # File.WRITE specifically creates a file if it does not exist.
		var headers = ["id", "credits", "winnings", "rating", "trial"] # Arbitrary headers for our CSV file, corresponds to Variables singleton.
		file.store_csv_line(headers, ",") # This writes those headers to the first line of the CSV file.
	
		file.seek_end() # I use this to move to the next line of the CSV, but there are other methods that may work better for your application.
		var sv = [Variables.playerid, Variables.credits, Variables.winnings, Variables.rating, Variables.trial] # This collects data from the singleton "Variables" and puts them into a PooledStringArray so we can write them to our CSV file.
		file.store_csv_line(sv, ",") # This saves our variables to the CSV.
	
		file.close() # This closes the file.
	
func _write(): # This is our function for updating our data
	var file = File.new() 
	file.open(data, File.READ_WRITE) # File.Read_Write specifically reads our file first so that it does not overwrite our data. 
	
	file.seek_end() # Makes sure its on a new line to write our data, but there may be a better way of doing this for your project. 
	var sv = [Variables.playerid, Variables.credits, Variables.winnings, Variables.rating, Variables.trial]
	file.store_csv_line(sv, ",")
	
	file.close()


func _on_Slots_write(): # Function that is connected to a signal.
	_write() # Execute our update function. 
