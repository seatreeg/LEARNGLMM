# generate some data
# here we know the underlying model
# but in real life, we obviously wouldnt 
# thats the point
set.seed(1)
n <- 2000#000 #200
x <- runif(n, 0, 100)
lambda <- exp(-2 + 0.06* x)
y <- rpois(n, lambda)

df <- data.frame(x = x, y = y)

plot(x,y)

# here we will make a poisson model from the data
poissonModel <- glm(y~x,family=poisson,data=df)

# show the results of the model
summary(poissonModel)
coef(poissonModel)

# we can see what the predictions would be for 5 values
predictVals <- data.frame(x = c(10, 20, 30, 40, 50))
predict(poissonModel, newdata = predictVals, type = "response")

# this is very close to how we modeled the simulation
( exp(-1 + 0.05 * predictVals) )


# get emeans for 5 values
library(emmeans)
emeanRes <- emmeans(poissonModel, ~ x, at = list(x = c(10, 20, 30, 40, 50) ), type = "response")
emeanRes



linmod <- lm(y~x, data = df)
emmeans( linmod, ~x, at = list(x=c(5,25,45)), type="response" )

predict(poissonModel, newdata = predictVals, type = "response")  
predict( linmod, newdata = predictVals, type = "response")  




predList <- seq(min(df$x), max(df$x), length.out = 200)
predictions <- data.frame(x=predList)

predictions$poissonModel <- predict(poissonModel, newdata = predictions, type = "response")
predictions$lineaPredictions <- predict(linmod, newdata = predictions, type = "response")

lines(predictions$x, predictions$poissonModel, col="red",lwd=2)

lines(predictions$x, predictions$lineaPredictions, col="blue",lwd=2)


