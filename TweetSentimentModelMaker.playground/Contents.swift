import Cocoa
import CreateML

let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/xxx/Workspace/iOS-tutorial/twitter-sanders-apple3.csv"))

// training data : testing data = 80 : 20
let (trainingData, testingData) = data.randomSplit(by: 0.8, seed: 5)

// textColumn and labelColumn depend on the .csv file
let sentimentClassfier = try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "class")

// test the model
let evaluationMetrics = sentimentClassfier.evaluation(on: testingData)
let evaluationAccuracy = (1 - evaluationMetrics.classificationError) * 100

// create our own mlmodel
let metadata = MLModelMetadata(author: "Catherine", shortDescription: "A model trained to classify sentiment on Tweets", license: "MIT", version: "0.1")
try sentimentClassfier.write(to: URL(fileURLWithPath: "/Users/xxx/Workspace/iOS-tutorial/tweetSentimentClassifer.mlmodel"), metadata: metadata)

// predict
try sentimentClassfier.prediction(from: "@Apple is a terrible company")
try sentimentClassfier.prediction(from: "I just found the best restaurant ever, and it's @Taco Bell")
try sentimentClassfier.prediction(from: "I think @CocaCola ads are just ok")

