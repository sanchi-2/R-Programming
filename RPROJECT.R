setwd("C:\\Users\\new\\Downloads")
unzip("C:\\Users\\new\\Downloads\\iris.zip", exdir = "C:\\Users\\new\\Downloads")
data1 <- read.csv("C:\\Users\\new\\Downloads\\iris.names")
 View(data1)
 summary(data1)
 

hist(iris$Sepal.Length, 
main = "Distribution of Sepal Length", 
xlab = "Sepal Length",
col = "lightblue"
)
hist(iris$Petal.Length,
main = "Distribution of Petal Length",
xlab = "Petal Length",
col = "lightgreen"
)
plot(density(iris$Sepal.Length),
main = "Density Plot of Sepal Length",
xlab = "Sepal Length",
col = "red"
)
boxplot(iris$Sepal.Length,
main = "Boxplot of Sepal Length",
col = "lightblue",
horizontal = TRUE
)
boxplot(Petal.Length ~ Species,
data = iris,
main = "Boxplot of Petal Length by Species",
col = c("lightblue", "lightgreen", "lightpink")
)

# Scatter plot between Sepal Length and Petal Length
plot(iris$Sepal.Length,
iris$Petal.Length,
main = "Sepal Length vs Petal Length",
xlab = "Sepal Length",
ylab = "Petal Length",
col = iris$Species
)
legend("topright", legend = levels(iris$Species), col = 1:3, pch = 1)
