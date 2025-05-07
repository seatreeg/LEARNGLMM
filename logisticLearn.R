# generate some data
# here we know the underlying model
# but in real life, we obviously wouldnt 
# thats the point
set.seed(1)
n <- 200#000
x <- runif(n, 0, 50)
p <- 1 / (1 + exp(-(-25 + 1 * x))) 
y <- rbinom(n, size = 1, prob = p)   

df <- data.frame(x = x, y = y)


plot(x,y)

# here we make a logistic regression model of the data
logitModel <- glm(y ~ x, family = binomial, data = df)

# show the model results
summary(logitModel)
coef(logitModel)

# make predictions for 5 values
predictVals <- data.frame(x = c(5,25,45))
predict(logitModel, newdata = predictVals, type = "response")  

# this is very close to how we modeled the simulation
1 / (1 + exp(-(-3 + 0.1 * predictVals$x))) 

# get marginal means for 5 values
library(emmeans)
emeanRes <- emmeans(logitModel, ~ x, at = list(x = c(10, 20, 30, 40, -30)), type = "response")
emeanRes

linmod <- lm(y~x, data = df)
emmeans( linmod, ~x, at = list(x=c(5,25,45)), type="response" )

predict(logitModel, newdata = predictVals, type = "response")  
predict( linmod, newdata = predictVals, type = "response")  




predList <- seq(min(df$x), max(df$x), length.out = 200)
predictions <- data.frame(x=predList)

predictions$logitPredictions <- predict(logitModel, newdata = predictions, type = "response")
predictions$lineaPredictions <- predict(linmod, newdata = predictions, type = "response")

lines(predictions$x, predictions$logitPredictions, col="red",lwd=2)

lines(predictions$x, predictions$lineaPredictions, col="blue",lwd=2)
