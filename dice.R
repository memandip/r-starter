roll <- function(){
  die <- 1:6
  dice <- sample(die, size = 2, replace = TRUE)
  print(dice)
  sum(dice)
}

roll()

age.groups <- c(1:99)

check.age <- function(age){
  if(age <= 15){
    print("Small")
  } else if(age <= 60) {
    print("Elder")
  } else if(age <= 99) {
    print("Older")
  }
}

check.age(16)